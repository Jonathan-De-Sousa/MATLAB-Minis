function C=circle(x,y,r,theta1,theta2)
%circle(x,y,r,theta1,theta2) plots a cirlce segment with centre (x,y) and 
%radius r, defined between angles theta1 and theta2 in radians

theta=linspace(theta1,theta2,20);
X=r*cos(theta)+x;
Y=r*sin(theta)+y;

for w=1:length(theta)-1
    plot([X(w);X(w+1)],[Y(w);Y(w+1)],'b'); axis equal
    pause(0.001)
    hold on;
end


