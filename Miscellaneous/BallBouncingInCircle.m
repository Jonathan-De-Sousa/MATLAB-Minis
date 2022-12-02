% Simulation of a ball bouncing inside of a circle.
% Written by Jonathan De Sousa.
% Date: 24/08/2021

% Clear workspace and screen 
clear 
clc

%% Problem parameters
delta_t = 0.01; % timestep
T = 10; % integration/simulation time
N = floor(T/delta_t); % number of timesteps

a = [0;-9.81]; % x,y gravitational acceleration
e = 1; % coefficient of restitution

R = 1; % radius of circle 
r = 0.05; % radius of ball

%% Initial conditions 
X = [0.75;0]; % x, y coordinates
U = [0;0]; % u, v coordinates

%% Simulate problem over integration time

% First timestep
if T > 0 
    U = U + a*delta_t/2;
    X = X + U*delta_t;
 
    % Boundary conditions
    if norm(X) > (R-r)
        THETA = angle(X(1)+1i*X(2));
        rim = [R*cos(THETA);R*sin(THETA)];
        
        if X(2) >= 0
            % 1st quadrant
            if X(1) >= 0 
                X = rim - r;
            % 2nd quadrant 
            else
                X = rim + [r;-r];
            end
        else
            % 3rd quadrant
            if X(1) <= 0
                X = rim + r;
                % 4th quadrant
            else
                X = rim + [-r;r];
            end
        end
        
        % Resolve velocity tangentially and perpendicularly relative to local tangent
        phi = 90 + THETA;
        theta = angle(U(1)+1i*U(2));
        beta = phi - theta;
        
        U_loc = [U*cos(beta);U*sin(beta)];
        U_loc(2) = -U_loc(2)*e;
        
        % Resolve local velocity back to global coordinates
        beta = angle(U_loc(1)+1i*U_loc(2));
        U = norm(U_loc);
        U = [U*cos(beta+phi);U*sin(beta+phi)];
    end
    
    for t = 2:N
        plot(R*cos(0:0.01:2*pi),R*sin(0:0.01:2*pi),'-b')
        hold on
        plot(X(1),X(2),'.r','Markersize',20)
        axis equal
        pause(0.01)
        hold off
        
        U = U + a*delta_t;
        X = X + U*delta_t;
        
        % Boundary conditions
        if norm(X) > (R-r)
            THETA = angle(X(1)+1i*X(2));
            rim = [R*cos(THETA);R*sin(THETA)];
            
            if X(2) >= 0
                % 1st quadrant
                if X(1) >= 0
                    X = rim - r;
                    % 2nd quadrant
                else
                    X = rim + [r;-r];
                end
            else
                % 3rd quadrant
                if X(1) <= 0
                    X = rim + r;
                    % 4th quadrant
                else
                    X = rim + [-r;r];
                end
            end
            
            % Resolve velocity tangentially and perpendicularly relative to local tangent
            phi = 90 + THETA;
            theta = angle(U(1)+1i*U(2));
            beta = phi - theta;
            
            U_loc = [U*cos(beta);U*sin(beta)];
            U_loc(2) = -U_loc(2)*e;
            
            % Resolve local velocity back to global coordinates
            beta = angle(U_loc(1)+1i*U_loc(2));
            U = norm(U_loc);
            U = [U*cos(beta+phi);U*sin(beta+phi)];
        end
    end
end