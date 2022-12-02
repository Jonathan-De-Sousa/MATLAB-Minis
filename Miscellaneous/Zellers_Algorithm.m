%Script that determines the day of the week using Zeller's algorithm
%Written by Jonathan De Sousa
%Date: 17-08-2019

%Clear workspace and screen
clear
clc
close all

%Prompt user for date
disp(['-----Input date-----'])
d=input('Day: ');
m=input('Month: ');
y=input('Year: ');

if m<3
    m=m+10;
    y=y-1;
else
    m=m-2;
end

C=mod(y,100);
D=(y-C)/100;
X=floor(C/4);
Y=floor(D/4);
B=d;
W=floor(13*m-1)/5;
R=floor(W+X+Y+B+C-2*D);

if R>6 || R<0
   R=mod(R,7);
end

switch(R)
    case(0)
        DoW=['Sunday'];
    case(1)
        DoW=['Monday'];
    case(2)
        DoW=['Tuesday'];
    case(3)
        DoW=['Wednesday'];
    case(4)
        DoW=['Thursday'];
    case(5)
        DoW=['Friday'];
    case(6)
        DoW=['Saturday']
end

disp(['Day of the week: ',DoW])



