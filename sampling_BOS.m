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

% obtain discrete derivative
dfddt = gradient(fd,timestep)

disp(['the sampling frequency is:    ' num2str(fs)])

% plot solution
plot(td,fd,'--k','LineWidth',2)
plot(td,dfddt,':k','LineWidth',2)
