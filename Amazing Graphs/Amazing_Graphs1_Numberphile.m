%Script that plots several graphs as seen in the Numberphile video "Amazing
%Graphs I"
%Written by Jonathan De Sousa (in Madeira)
%Date: 08-08-2019

%Clear workspace and screen
clear
clc

%Create x-coordinate array
x=[0:10000];

%----------------------------------------------------------%
%Graph 1 (Parabola)
y1=x.^2; %square every x term
figure(1)
plot(x,y1,'.b')

%----------------------------------------------------------%
%Graph 2 (Square Root)
y2=x.^0.5; %square root every x term
figure(2)
plot(x,y2,'.b')

%----------------------------------------------------------%
%Graph 3 (Fly Straight)
x=[0:1000]
y3(1)=1;
y3(2)=1;
for i=3:length(x)
        GCD=gcd(x(i),y3(i-1)); %find greatest common denominator
        if GCD==1
            y3(i)=y3(i-1)+i;
        else y3(i)=y3(i-1)/GCD;
        end
end
figure(3)
plot(x,y3,'.b')

%----------------------------------------------------------%
%Graph 4 (Primes)
x=[0:10000]
primeNumbers = [1];
n=1;
%Create array of prime numbers whose length equals that of x
while length(primeNumbers) < length(x)
    primeNumbers=primes(n); %find first N=length(x) primes
    n=n+1;
end

for i=1:length(x)
    binaryP=decimalToBinaryVector(primeNumbers(i)); %convert prime to binary
    binaryPf=fliplr(binaryP); %reverse prime binary vector
    dec=binaryVectorToDecimal(binaryPf); %convert reversed vector to decimal
    y4(i)=primeNumbers(i)-dec;
end
figure(4)
plot(x,y4,'.b')

