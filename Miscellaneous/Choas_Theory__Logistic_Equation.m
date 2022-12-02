%Script that plots the behaviour of a dynamic system that obeys the
%logistic equation for different values of k.
%Date: 02-07-2019
%Written by Jonathan De Sousa

%Clear workspace and screen
clear
clc
close all

%Initialise constants
kspace = linspace(0,5,6); %growth rate of system

%Plot dynamic behaviour for different values of k
for u=1:length(kspace)
    x0 = 0.1; %initial value of system
    %Note: x0=1-(1/k) will given a stable dynamic behaviour because
    %      this is the value for which x0=x1 for every iteration
    k=kspace(u);
    %Iterate system's dynamic behaviour using logistic equation
    for i=1:100
        x1=k*x0*(1-x0);
        subplot(3,2,u)
        plot([i-1,i],[x0,x1],'-b.')
        hold on
        x0=x1;
    end
end

hold off