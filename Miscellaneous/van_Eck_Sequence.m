%Van Eck sequence
%Date: 11-06-2019
%Written by Jonathan De Sousa

%clear homespace and workspace
clear
clc
close all %close all open figures

%Initialise first 2 terms of sequence
vEck = [0,0];

i = 2;
while i < 100000
    vEck(i+1)=0; 
    for u=(length(vEck)-2):-1:1
        if vEck(i)==vEck(u);
            vEck(i+1)=i-u;
            break
        end
    end
    i=i+1;
end

%Plot van Eck sequence
x=[1:length(vEck)];
plot(x,vEck,'-')


        