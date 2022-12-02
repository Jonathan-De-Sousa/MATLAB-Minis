% Mandelbrot set 
% Written by Jonathan De Sousa
% Date: 07-07-2022

% clear workspace and screen
clear
clc
close all

% Figure formatting
set(groot,'defaulttextinterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultAxesFontSize', 12)
set(groot, 'defaultTextFontSize', 15)

%%

% Option (1 or 0) to exploit symmetry about Im axis to reduce compute time
exploit_symm = 1;

% Local point to zoom on in 
% For full Mandelbrot set: Re = [-2,1], Im = [-1,1]
Re_zoomPt = -1.5;
Im_zoomPt = 0;

% Zoom magnification
zoomMag = 1;

% Discretize imaginary and real coordinates within major boundary of set
% If exploit_symm == 1, enter only upper or lower half Im-plane
delta = 1;
resolution = 500;

Re = (Re_zoomPt-delta/zoomMag):(2*delta/zoomMag)/resolution:(Re_zoomPt+delta/zoomMag);
if exploit_symm
    Im = 0:(2*delta/zoomMag)/resolution:(Im_zoomPt+delta/zoomMag);
else
    Im = (Im_zoomPt-delta/zoomMag):(2*delta/zoomMag)/resolution:(Im_zoomPt+delta/zoomMag);
end


%Original values
% Re = -2:0.001:1;
% Im = 0:0.001:1; % if exploit_symm == 1, enter only upper or lower half plane

%Create meshgrid
[X,Y]=meshgrid(Re,Im);

% Form array representing discretized complex plane
C=X+1i*Y;

%%

max_iter = 1*10^2; %max interations - used as convergence criteria
max_mod=10^5; %max modulus of z - used as divergence criteria
mandelbrot_iter = ones(size(C))*max_iter;

for u = 1:size(X,1)
    for v = 1:size(Y,2)
        
        z_0 = 0; %initial z-value
        C_m = C(u,v); %set as constant so that no need to constantly call C(u,v)
        count = 0;
        
        while count < max_iter
            z_n = z_0^2 + C_m;
            if abs(z_n) > max_mod
                mandelbrot_iter(u,v) = count;
                break
            end
            
            z_0 = z_n;
            count = count + 1;
        end
    end
end

%% Plot Mandelbrot set

figure
[~,h1] = contourf(real(C),imag(C),mandelbrot_iter,100);
set(h1,'LineColor','none')

if exploit_symm
    hold on
    [~,h2] = contourf(real(C),-imag(C),mandelbrot_iter,100);
    hold off
    set(h2,'LineColor','none')
end

colormap(flipud(jet))
xlabel('Re(z)')
ylabel('Im(z)')
title('Mandelbrot Map','FontSize',15)
axis equal
