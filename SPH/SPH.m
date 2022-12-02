% SPH script
% Solves a 2D smoothed particle hydrodynamic (SPH) formulation of the
% Navier-Stokes equations.
%
% Written by Jonathan De Sousa
% Date: 28/06/2021

% clear workspace and screen
clear
clc
close all

% Start timer 
tic

%% Particle/fluid properties

k     = 2000; % gas constant
rho_0 = 1000; % resting density
mu    = 1.0;  % viscosity
g     = 9.81; % gravitational acceleration
e     = 0.5;  % coefficient of restitution
m     = 1.0;  % initial mass of each particle

%% Available inputs

% Initial conditions
disp('----------Available initial conditions----------')
disp('Dam break : ic-dam-break')
disp('Block drop: ic-block-drop')
disp('Droplet   : ic-droplet')

% Prompt user for inputs
%disp('-----Enter values-----')
%ic = input('Initial condition-------------------: ','s');
%if ic == 'ic-droplet'
%    r_drplt = input('Droplet radius----------------------: ')
%end
%T  = input('Total simulation time---------------: ');
%dt = input('Time step---------------------------: ');
%h  = input('Radius of influence of each particle: ');

% default values
ic      = 'ic-droplet';
r_drplt = 0.1;
T       = 2;
dt      = 2.5e-3;
h       = 0.01;

N_t = floor(T/dt); % number of timesteps
%% Set particle initial conditions

% Pre-computation of part of noise expression to be added to initial
% particle positions.
% Noise added is no greater than 20% of h.
noise = h*0.2;

% Set particle coordinates based on initial conditions
if strcmp(ic,'ic-dam-break') || strcmp(ic,'ic-block-drop')
    if strcmp(ic,'ic-dam-break')
        x1 = 0.2;
        y1 = 0.2;
        x0 = h; % set to h instead of 0...
        y0 = h; % ... due to boundary condition
    else
        x1 = 0.3;
        x0 = 0.1;
        y1 = 0.6;
        y0 = 0.3;
    end
    iRow = floor(((y1 - y0) / h) + 1);
    iCol = floor(((x1 - x0) / h) + 1);
    N = iRow*iCol;
    
    x = zeros(1,N);
    y = zeros(1,N);
    size(x)
    for i = 0:(iCol-1)
        for j = 0:(iRow-1)
            x(i*iRow + j + 1) = x0 + i*h;% + rand()*noise*(-1)^ceil((2*rand()));
            y(i*iRow + j + 1) = y0 + j*h;% + rand()*noise*(-1)^ceil((2*rand()));
        end
    end
else
    % Droplet case is default case
    % Create square grid encapsulating circle centre (0.5, 0.7), radius 0.1
    % Then only include points within circle to be set into x and y arrays.
    
    iRow = floor((2*r_drplt / h) + 1);
    iCol = floor((2*r_drplt  / h) + 1);
    N = iRow*iCol; % N elements in square grid
    
    % Ratio (Area_circle : Area_square) = pi/4 = 0.785, so can roughly set
    % N for droplet.
    % N_circle <= N_square * pi/4 [ALWAYS] (N_circle = N_square * pi/4 as
    % N--> infty)
    N = floor(N*0.79);
    
    x = zeros(1,N);
    y = zeros(1,N);
    N = 1; %number of particles in circle
    for i = 0:(iCol-1)
        for j = 0:(iRow-1)
            x_temp = 0.5 - r_drplt + i*h;
            y_temp = 0.7 - r_drplt + j*h;
            % Add all points inside circle to x & y arrays
            if ((x_temp - 0.5)^2 + (y_temp - 0.7)^2) <= r_drplt^2
                x(N) = x_temp + rand()*noise*(-1)^ceil((2*rand()));
                y(N) = y_temp + rand()*noise*(-1)^ceil((2*rand()));
                N = N+1;
            end
        end
    end
    % Clear unused allocated memory
    N = N-1;
    x(N+1:end) = [];
    y(N+1:end) = [];
end

%% Initialise arrays

% Initial velocities
vx = zeros(1,N); % x-direction velocity
vy = zeros(1,N); % y-direction velocity

EK = zeros(1,N+1); % kinetic energy
EP = zeros(1,N+1); % potential energy
ET = zeros(1,N+1); % total energy

%% Solve dynamic SPH problem over integration time T

% Pre-computations of constants for SPH solve_*.m functions
inv_h = 1/h;
valp = -k*rho_0;
valrho = m*4.0/(pi*h^2);

[q, rx, ry] = solve_q(x, y, inv_h, N);
rho = solve_rho(N, valrho, q);
    
% Scale mass so that density is equal to reference density
m = N*rho_0/sum(rho);
    
% Initial energy ("zeroth timestep")
EK(1) = 0.5*m*sum(vx.^2+vy.^2);
EP(1) = m*g*sum(y);
ET(1) = EK(1) + EP(1);

if N_t > 0
    % Pre-compute mass-dependent constants in solve_*.m functions
    valrho = m*4/(pi*h^2);
    valFp = m*30/(2*pi*h^3);
    valFv = mu*m*40/(pi*h^4);
    
    rho = solve_rho(N, valrho, q); % re-calculate density with new mass
    p = solve_p(N, k, rho, valp);
    [ax,ay] = solve_F(N, rho, rx, ry, q, p, g, vx, vy, valFp, valFv);
    
    % First timestep
    vx = vx + ax*dt/2;
    vy = vy + ay*dt/2;
    
    x = x + vx*dt;
    y = y + vy*dt;
    
    [x, y, vx, vy] = checkBC(N, h, e, x, y, vx, vy);
    
    % Pre-computations of partial EK & EP expressions
    valEK = 0.5*m;
    valEP = m*g;
    
    EK(2) = valEK*sum(vx.^2 + vy.^2);
    EP(2) = valEP*sum(y);
    ET(2) = EK(2) + EP(2);
    
    % Advance for remaining timesteps
    for i = 0:(N_t-1)
        [q, rx, ry] = solve_q(x, y, inv_h, N);
        rho = solve_rho(N, valrho, q);
        p = solve_p(N, k, rho, valp);
        [ax,ay] = solve_F(N, rho, rx, ry, q, p, g, vx, vy, valFp, valFv);
        
        vx = vx + ax*dt;
        vy = vy + ay*dt;
        
        x = x + vx*dt;
        y = y + vy*dt;
        
        [x, y, vx, vy] = checkBC(N, h, e, x, y, vx, vy);
        
        EK(i+2) = valEK*sum(vx.^2+vy.^2);
        EP(i+2) = valEP*sum(y);
        ET(i+2) = EK(i+2) + EP(i+2);
        
        % Visualise simulation
        figure(1)
        % Plot box
        plot([0 0], [0 1],'-r','Linewidth',2)
        hold on
        plot([1 1], [0 1],'-r','Linewidth',2)
        plot([0 1], [0 0],'-r','Linewidth',2)
        plot([0 1], [1 1],'-r','Linewidth',2)
        axis equal
        % Plot particles
        plot(x,y,'.b','Markersize',5)
        pause(0.01)
        hold off
    end
end

figure(2)
hold on
plot_EK = plot(0:dt:T, EK, '-b');
plot_EP = plot(0:dt:T, EP, '-r');
plot_ET = plot(0:dt:T, ET, '-k');
legend([plot_EK,plot_EP,plot_ET],'Kinetic enegy', 'Potential energy', 'Total energy')
grid minor
xlabel('Time')
ylabel('Energy')

% Stop timer
toc