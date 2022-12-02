%SCript that calculates the theoretical temperature of a planet orbitting
%the Sun.
%Assumptions:
% -Bodies are taken to be black bodies.
% -Temperature of space is negligibly small, near absolute zero. 
%Written by Jonathan De Sousa
%Date: 14 May 2019

%housekeeping
clear
clc
close all

%Set constants
T_Sun = 5778; %Sun's surface temperature (K)
r_Sun = 695510000; %Sun's radius (m)
sigma = 5.67*10^-8; %Stefan Boltzmann constant

%Prompt user for data
r_orbit = input('Orbital radius (km): ')*1000;  
r_planet = input('Planet`s radius (km): ')*1000;

%Calculations
Q_Sun = 4*pi*r_Sun^2*sigma*T_Sun^4; %heat flux density of Sun 
A_orbit = 4*pi*r_orbit^2; %orbital spherical area
SC = Q_Sun/A_orbit; %Solar constant
A_shadow_planet = pi*r_planet^2; %planet`s shadow area
A_spherical_planet = 4*pi*r_planet^2; %planet`s spherical area

E = SC*A_shadow_planet; %rate of heat received
T_planet = (E/(A_spherical_planet*sigma))^(1/4);

%Display planet`s temperature
disp(['Planet`s theoretical temperature: ',num2str(T_planet), ' K, or ',num2str(T_planet - 273.15),' C'])

