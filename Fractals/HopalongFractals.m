% Hopalong Fractals (pg. 22)
% Written by Jonathan De Sousa
% Date: 03/07/2022

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

%% Duffing Attractor

delta_x = 0.001;
delta_y = 0.5;
x = -2:delta_x:2;
y = -2:delta_y:2;

x_map = zeros(length(x),length(y));
y_map = zeros(length(x),length(y));

for i = 1:length(x)
    for j = 1:length(y)
        x_map(i,j) = 2.27*x(i) - 0.2*y(j) - x(i)^3;
        y_map(i,j) = x(i);
    end
end

figure
plot(x_map,y_map,'.w','MarkerSize',1)
set(gca,'Color','k')
axis equal
title('Duffing Attractor')

%% Tinkerbell Attractor

delta_x = 0.1;
delta_y = 0.1;
x = -5:delta_x:5;
y = -5:delta_y:5;

x_map = zeros(length(x),length(y));
y_map = zeros(length(x),length(y));

for i = 1:length(x)
    for j = 1:length(y)
        x_map(i,j) = x(i)^2 - y(j)^2 + 0.9*x(i) - 0.6*y(j);
        y_map(i,j) = 2*x(i)*y(j) + 2*x(i) + 0.5*y(j);
    end
end

figure
plot(x_map,y_map,'.w','MarkerSize',2)
set(gca,'Color','k')
axis equal
title('Tinkerbell Attractor')

%% de Jong Attractor

delta_x = 0.02;
delta_y = 0.01;
x = 0:delta_x:3;
y = 0:delta_y:3;

x_map = zeros(length(x),length(y));
y_map = zeros(length(x),length(y));

for i = 1:length(x)
    for j = 1:length(y)
        x_map(i,j) = sin(2*y(j)) - cos(2.5*x(i));
        y_map(i,j) = sin(x(i)) - cos(y(j));
    end
end

figure
plot(x_map,y_map,'.w','MarkerSize',2)
set(gca,'Color','k')
axis equal
title('de Jong Attractor')

%% Linton's Ghost

delta_x = 0.05;
delta_y = 0.05;
x = -2:delta_x:2;
y = -10:delta_y:10;

x_map = zeros(length(x),length(y));
y_map = zeros(length(x),length(y));

for i = 1:length(x)
    for j = 1:length(y)
        x_map(i,j) = sin(1.2*y(j));
        y_map(i,j) = -x(i) - cos(2*y(j));
    end
end

figure
plot(x_map,y_map,'.w','MarkerSize',2)
set(gca,'Color','k')
axis equal
title("Linton's Ghost")

%% Classic Barry Martin Attractor

delta_x = 1;
delta_y = 1;
x = -50:delta_x:50;
y = -50:delta_y:50;

x_map = zeros(length(x),length(y));
y_map = zeros(length(x),length(y));

for i = 1:length(x)
    for j = 1:length(y)
        x_map(i,j) = y(j) - sign(x(i)) * sqrt(abs(4*x(i) - 0.5));
        y_map(i,j) = 1 - x(i);
    end
end

figure
plot(x_map,y_map,'.w','MarkerSize',2)
set(gca,'Color','k')
axis equal
title("Classic Barry Martin Attractor")