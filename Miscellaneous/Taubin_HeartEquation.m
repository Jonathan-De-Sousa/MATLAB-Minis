%clear workspace and screen
clear 
clc
close all

%Taubin Equation
for i=1:30
    %Play with where to place i for a cool tranformation/formation of a
    %heart
    f=@(x,y,z) (10*x.^2+y.^2+z.^2-1).^3-x.^2.*z.^3/10-y.^2.*z.^3;
    %Original Taubin Equation
    %f=@(x,y,z) (10*x.^2+y.^2+z.^2-1).^3-x.^2.*z.^3/10-y.^2.*z.^3;
    axis equal
    if mod(i,3)==1
        fimplicit3(f,'r')
    elseif mod(i,3)==2
        fimplicit3(f,'b')
    else
        fimplicit3(f,'m')
    end
    pause(0.001)
end
title('Je t`aime mon F1 ange <3')