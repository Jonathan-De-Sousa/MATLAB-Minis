%clear workspace and screen
clear 
clc
close all
%Taubin Equation
for i=0:0.04:2
     f=@(x,y,z) (10*x.^2+y.^2+z.^i-1).^3-x.^2.*z.^3/10-y.^2.*z.^3;
      if i>=2
          for j=0:20
            if mod(j,2)==1
                fimplicit3(f,'m')
            elseif mod(j,2)==0
                fimplicit3(f,'g')
            end
            title(['\fontsize{16} {\color{magenta}HAPPY BIRTHDAY <3}'])
            %title(['\fontsize{16}black {\color{magenta}magenta '])
            pause(0.001)
          end
      else
    %Play with where to place i for a cool tranformation/formation of a
    %heart
   
    %Original Taubin Equation
    %f=@(x,y,z) (10*x.^2+y.^2+z.^2-1).^3-x.^2.*z.^3/10-y.^2.*z.^3;
    axis equal
    %if mod(i,3)==1
     %   fimplicit3(f,'r')
    %elseif mod(i,3)==2
     %   fimplicit3(f,'b')
    %else
     %   fimplicit3(f,'m')
    %end
    fimplicit3(f)
    pause(0.001)
      end
end