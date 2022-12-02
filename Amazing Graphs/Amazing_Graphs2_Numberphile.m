%Script that plots several graphs as seen in the Numberphile video "Amazing
%Graphs II"
%Written by Jonathan De Sousa (in Madeira)
%Date: 28-09-2019

%clear workspace and screen
clear
clc
close all

%----------------------------------------------------------%
%Graph 1 (Balanced Tenary)

%Initialise independent variable values
x=[1:1000];

%Convert each x-value into tenary
for i=1:length(x)
    T=dec2tern(i);
    %Replace all 2's in T by -1
    twos=find(T==2);
    T(twos)=-1;
    %Initialise sum of T's terms
    sum=0;
    for u=1:length(T)
        val=T(u)*3^(length(T)-u);
        sum=sum+val;
    end
    y1(i)=sum;
end
figure(1)
plot(x,y1,'.')

%----------------------------------------------------------%
%Graph 2 (Wisteria)

%Initialise independent variable values
x=[1:2000];

for i=1:length(x)
    %Split x value integer into its constituent digits
    Ndigits=dec2base(i,10)-'0';
    %Get rid of all 0's in x value
    Ndigits(find(Ndigits==0))=[];
    %Multiply remaining digits together and subtract from x value
    y2(i)=i-prod(Ndigits);
end
figure(2)
plot(x,y2,'.')

%Graph 3 (Forest Fire)

%Initialise independent variable values
x=[1:1000];

%Initialise first 2 dependent variable values
y3([1,2])=[1,1];

%Initialise odd or even identifier of counter
odd=1;

for i=3:length(x)
    if odd==1
        N=floor(i/2);
    else
        N=(i/2)-1;
    end
    y3(i)=1;
    v=0;
    while v<N+1 
        v=v+1;
        for u=1:N
            if y3(i)-y3(i-u)==y3(i-u)-y3(i-2*u)
                y3(i)=y3(i)+1;
                v=1;
            end
        end
    end
    odd=mod(1,odd);
end

figure(3)
plot(x,y3,'.')