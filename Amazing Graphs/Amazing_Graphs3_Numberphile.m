%Script that plots several graphs as seen in the Numberphile video "Amazing
%Graphs III"
%Written by Jonathan De Sousa (in Madeira)
%Date: 29-09-2019

%Clear workspace and screen
clear
clc

%----------------------------------------------------------%
%Graph 1 (Stern's Sequence)
%WORK IN PROGRESS

%----------------------------------------------------------%
%Graph 2 (Hofstadter's Q Sequence)

%Initialise independent variable values
x=[1:10000];

%Initialise first 2 dependent variable values
y2([1,2])=[1,1];

for i=3:length(x)
    y2(i)=y2(i-y2(i-1))+y2(i-y2(i-2));
end

figure(5)
plot(x,y2,'.')

%----------------------------------------------------------%
%Graph 3 (Chaotic Cousin)

%Initialise independent variable value
x=[1:100000];

%Initialise first 2 values of depedent variable 
y3([1,2])=[1,1];

for i=3:length(x)
    y3(i)=y3(y3(i-1))+y3(i-1-y3(i-2));
end

figure(6)
plot(x,y3,'.')

%----------------------------------------------------------%
%Graph 4 (Rémy Sigrist)
%NEEDS FIXING
%Initialise independent variable value
x=[1:100];

%Determine maximum required size of binary vector to store largest x-value
sizex=floor(log2(length(x))+1);

%Convert each x value into binary. 
%Store each value in a row of a matrix
for i=1:length(x)
    M(i,[1:sizex])=dec2bin(i,sizex)-'0';
end

%Initialise the first dependent variable value
y4=0;

%Initialise dependent variable counter
count=0;

for u=2:length(x)
    logic=0;
    for v=1:u-1
        S=sum(M(u,:).*M(v,:));
        if S==1
            logic=1;
        end
    end
    if logic==1;
        count=count+1;
        y4(u)=count;
    else
        y4(u)=0;
    end
end

figure(4)
plot(x,y4,'.')