%Script that randomly joins points on a circle
%Written by Jonathan De Sousa
%Date: 19-06-2019

%clear workspace and screen
clc
clear
close all

%Plot circle
theta=linspace(0,2*pi,500);
X=10*cos(theta);
Y=10*sin(theta);
plot(X,Y,'r-')
hold on

theta=linspace(0,2*pi,250);
X=10*cos(theta);
Y=10*sin(theta);

var=ceil(250*rand(1));

x1=X(var);
y1=Y(var);

for i=1:500
    var=ceil(250*rand(1));
    x=X(var);
    y=Y(var);
    plot([x;x1],[y;y1],'b-')
    axis equal
    x1=x;
    y1=y;
    hold on
    pause(0.01)
end
    
hold off

