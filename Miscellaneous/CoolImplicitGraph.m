clear
clc
close all

meshdensity = 2500;
axlim = 50;

%%
figure
f = @(x,y) sin(sin(x.*(sin(y)-cos(x))))-cos(cos(y.*(cos(x)-sin(y))));
fimplicit(f,[-axlim axlim -axlim axlim],'MeshDensity',meshdensity,'LineWidth',0.1)

axis square

%%
figure
f = @(x,y) sin(sin(tan(x).*(sin(y)-cos(x))))-cos(cos(tan(y).*(cos(x)-sin(y))));
fimplicit(f,[-axlim axlim -axlim axlim],'MeshDensity',meshdensity,'LineWidth',0.1)

axis square

%%
figure
f = @(x,y) sin(x.^2+y.^2);
fimplicit(f,[-axlim axlim -axlim axlim],'MeshDensity',meshdensity,'LineWidth',0.1)

axis square

%%
figure
f = @(x,y) sin(x.^2-y.^2);
fimplicit(f,[-axlim axlim -axlim axlim],'MeshDensity',meshdensity,'LineWidth',0.1)

axis square

%%
figure
f = @(x,y) sin(x.^3+y.^3);
fimplicit(f,[-axlim axlim -axlim axlim],'MeshDensity',meshdensity,'LineWidth',0.1)

axis square

%%
figure
f = @(x,y) sin(x.^3-y.^3);
fimplicit(f,[-axlim axlim -axlim axlim],'MeshDensity',meshdensity,'LineWidth',0.1)

axis square