% Random walk
% Written by Jonathan De Sousa
% Date: 26-06-2021

% clear workspace and screen
clear 
clc
close all

% User inputs
x1 = 0;
y1 = 0;
N = 1000;
%x1 = input('Enter starting x-coordinate: ');
%y1 = input('Enter starting y-coordinate: ');
%N = input('Enter number of steps       : ');

% Set up unit square box domain
hold on
axis equal
plot([1 1], [1 -1],'-r','Linewidth', 2)
plot([-1 -1], [1 -1],'-r','Linewidth', 2)
plot([-1 1], [-1 -1],'-r','Linewidth', 2)
plot([-1 1], [1 1],'-r','Linewidth', 2)

% Random walk
for i = 1:N
    step_size = 0.2*rand + 0.05;
    step_dir = 2*pi*rand + 5*180/pi;
    x2 = x1 + step_size*cos(step_dir);
    y2 = y1 + step_size*sin(step_dir);
    
    % Enforce boundary conditions
    if x2 > 1
        x2 = 1;
    elseif x2 < -1
        x2 = -1;
    end
    if y2 > 1 
        y2 = 1;
    elseif y2 < -1
        y2 = -1;
    end
    
    plot([x1 x2], [y1 y2], '-b','Linewidth', 0.5)
    x1 = x2
    y1 = y2
    pause(0.2) 
end


