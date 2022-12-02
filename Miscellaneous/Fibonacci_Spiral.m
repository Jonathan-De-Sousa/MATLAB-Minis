%Fibonacci sequence represented as a spiral
%Date: 12-06-2019
%Written by Jonathan De Sousa

%clear screen and workspace
clear
clc
close all

N = 15; %number of Fibonacci terms in sequence

%Initliase first 2 terms of sequence
Fibo = [0,1,1];

%Create sequence
for i=1:N-2
    Fibo(i+2)=Fibo(i)+Fibo(i+1);
end

theta_seg=[0,pi/2,pi,3*pi/2,2*pi];

%Initialise centre
centre_x=0;
centre_y=0;

delta_x=[0,+1,0,-1]; %Sign operators to calculate Cartesian x-coordinate of quarter circle centres
delta_y=[-1,0,1,0]; %Sign operators to calculate Cartesian y-coordinate of quarter circle centres

v=1;

for i=1:N-1
    th=mod(v,5);
    if th==0
        th=1;
        v=v+1;
    end
    v=v+1;
    circle(centre_x,centre_y,Fibo(i+1),theta_seg(th),theta_seg(th+1))
    hold on;
    u=mod(i,4);
    if u==0
        u=4;
    end
    centre_x = centre_x + Fibo(i)*delta_x(u);
    centre_y = centre_y + Fibo(i)*delta_y(u); 
end

hold off;