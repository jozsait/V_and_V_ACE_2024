clear all;
close all;
clc;

%% DISCRETE SIGNAL REPRESENTATION
% number of points
N = 41;
% discrete time
td = linspace(0, 2*pi, N);
% the discrete function
fd = sin(td);

% sampling frequency
timestep = td(2)-td(1);
fs = 1/(timestep);

disp(['the sampling frequency is:    ' num2str(fs)])

%% POLYNOMIAL RECONSTRUCTION
poly_coeff = polyfit(td,fd,5);
fd_poly = polyval(poly_coeff,td);

% extended discrete time
td_ext = linspace(0, 3*pi, N);
fd_poly_ext = polyval(poly_coeff,td_ext);

%% PLOTTING
% plot solution
figure(1)
plot(td,fd,'ok')
hold on
plot(td,fd_poly,'-k','LineWidth',2)
plot(td_ext,fd_poly_ext,'b:','LineWidth',2)
