% Julia map
% Written by Jonathan De Sousa
% Date: 09-07-2022

% clear workspace and screen
clear
clc
close all

% Figure formatting
set(groot,'defaulttextinterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultAxesFontSize', 12)
set(groot, 'defaultTextFontSize', 11)

ColorMap = 'jet';
%% Julia set 1: c = -0.101 + 0.956i 

% Discretise Re and Im parts of complex plane
Re = -2:0.01:2;
Im = -2:0.01:2; 

% Mesh complex plane
[X,Y]=meshgrid(Re,Im);
Z=X+1i*Y;

% Set parameters
max_iter   = 2.75*10^1; %max interations - used as convergence criteria
max_mod    = 10^2; %max modulus of z - used as divergence criteria
julia_iter = ones(size(Z))*max_iter;
c          = -0.101 + 0.956j;

for u = 1:size(X,1)
    for v = 1:size(Y,2)
        
        Z_0 = Z(u,v); %set as constant so that no need to constantly call C(u,v)
        count = 0;
        
        while count < max_iter
            z_n = Z_0^2 + c;
            if abs(z_n) > max_mod
                julia_iter(u,v) = count;
                break
            end
            
            Z_0 = z_n;
            count = count + 1;
        end
    end
end

% Plot Julia set
figure
[~,h1] = contourf(real(Z),imag(Z),julia_iter,100);
set(h1,'LineColor','none')
colormap(flipud(ColorMap))
xlabel('Re(z)')
ylabel('Im(z)')
title(sprintf('Julia Map, c = %.3f + %.3fi',real(c),imag(c)),'FontSize',15)
axis equal

%% Julia set 2: c = 0.34 + 0.04i 

% Discretise Re and Im parts of complex plane
Re = -1.5:0.001:1.5;
Im = -1.5:0.001:1.5; 

% Mesh complex plane
[X,Y]=meshgrid(Re,Im);
Z=X+1i*Y;

% Set parameters
max_iter   = 1*10^2; %max interations - used as convergence criteria
max_mod    = 10^2; %max modulus of z - used as divergence criteria
julia_iter = ones(size(Z))*max_iter;
c          = 0.34 + 0.04j;

for u = 1:size(X,1)
    for v = 1:size(Y,2)
        
        Z_0 = Z(u,v); %set as constant so that no need to constantly call C(u,v)
        count = 0;
        
        while count < max_iter
            z_n = Z_0^2 + c;
            if abs(z_n) > max_mod
                julia_iter(u,v) = count;
                break
            end
            
            Z_0 = z_n;
            count = count + 1;
        end
    end
end

% Plot Julia set
figure
[~,h1] = contourf(real(Z),imag(Z),julia_iter,100);
set(h1,'LineColor','none')
colormap(flipud(ColorMap))
xlabel('Re(z)')
ylabel('Im(z)')
title(sprintf('Julia Map, c = %.3f + %.3fi',real(c),imag(c)),'FontSize',15)
axis equal

%% Julia set 2: c = -0.75 + 0.25i 

% Discretise Re and Im parts of complex plane
Re = -1.75:0.001:1.75;
Im = -1.5:0.001:1.5; 

% Mesh complex plane
[X,Y]=meshgrid(Re,Im);
Z=X+1i*Y;

% Set parameters
max_iter   = 1*10^2; %max interations - used as convergence criteria
max_mod    = 10^2; %max modulus of z - used as divergence criteria
julia_iter = ones(size(Z))*max_iter;
c          = -0.75 + 0.25j;

for u = 1:size(X,1)
    for v = 1:size(Y,2)
        
        Z_0 = Z(u,v); %set as constant so that no need to constantly call C(u,v)
        count = 0;
        
        while count < max_iter
            z_n = Z_0^2 + c;
            if abs(z_n) > max_mod
                julia_iter(u,v) = count;
                break
            end
            
            Z_0 = z_n;
            count = count + 1;
        end
    end
end

% Plot Julia set
figure
[~,h1] = contourf(real(Z),imag(Z),julia_iter,100);
set(h1,'LineColor','none')
colormap(flipud(ColorMap))
xlabel('Re(z)')
ylabel('Im(z)')
title(sprintf('Julia Map, c = %.3f + %.3fi',real(c),imag(c)),'FontSize',15)
axis equal

%% Julia set 2: c = 0.3 + 0.5i 

% Discretise Re and Im parts of complex plane
Re = -1.5:0.01:1.5;
Im = -1.5:0.01:1.5; 

% Mesh complex plane
[X,Y]=meshgrid(Re,Im);
Z=X+1i*Y;

% Set parameters
max_iter   = 1*10^2; %max interations - used as convergence criteria
max_mod    = 10^2; %max modulus of z - used as divergence criteria
julia_iter = ones(size(Z))*max_iter;
c          = 0.3 + 0.5i;

for u = 1:size(X,1)
    for v = 1:size(Y,2)
        
        Z_0 = Z(u,v); %set as constant so that no need to constantly call C(u,v)
        count = 0;
        
        while count < max_iter
            z_n = Z_0^2 + c;
            if abs(z_n) > max_mod
                julia_iter(u,v) = count;
                break
            end
            
            Z_0 = z_n;
            count = count + 1;
        end
    end
end

% Plot Julia set
figure
[~,h1] = contourf(real(Z),imag(Z),julia_iter,100);
set(h1,'LineColor','none')
colormap(flipud(ColorMap))
xlabel('Re(z)')
ylabel('Im(z)')
title(sprintf('Julia Map, c = %.3f + %.3fi',real(c),imag(c)),'FontSize',15)
axis equal