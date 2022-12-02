% Julia maps over range of c values
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

%% Discretise c-plane

% Discretise Re and Im parts of c-plane
Re_c = -4:0.25:2;
Im_c = -2:0.25:2; 

% Mesh c-plane
[X_c,Y_c] = meshgrid(Re_c,Im_c);
C = X_c + 1i*Y_c;

%% Create Julia maps

% Discretise Re and Im parts of complex plane
Re = -2:0.1:2;
Im = -2:0.1:2;

% Mesh complex plane
[X,Y] = meshgrid(Re,Im);
Z = X + 1i*Y;

% Set parameters
max_iter   = 7.5*10^1; %max interations - used as convergence criteria
max_mod    = 10^2; %max modulus of z - used as divergence criteria
julia_iter = ones([size(Z),size(C)])*max_iter;

for u_c = 1:size(X_c,1)
    for v_c = 1:size(Y_c,2)
        
        c = C(u_c,v_c);
        
        for u = 1:size(X,1)
            for v = 1:size(Y,2)
                
                Z_0 = Z(u,v); %set as constant so that no need to constantly call C(u,v)
                count = 0;
                
                while count < max_iter
                    z_n = Z_0^2 + c;
                    if abs(z_n) > max_mod
                        julia_iter(u,v,u_c,v_c) = count;
                        break
                    end
                    
                    Z_0 = z_n;
                    count = count + 1;
                end
            end
        end
    end
end

%% Plot Julia set

plot_count = 1;

figure
sgtitle('Julia Map Collage','FontSize',15)
for u_c = 1:size(X_c,1)
    for v_c = 1:size(Y_c,2)
        subplot(length(Im_c),length(Re_c),plot_count)
        [~,h1] = contourf(real(Z),imag(Z),julia_iter(:,:,u_c,v_c),100);
        set(h1,'LineColor','none')
        set(gca,'XTick',[])
        set(gca,'YTick',[])
        colormap(flipud(jet))
        axis equal

        plot_count = plot_count + 1;
    end
end