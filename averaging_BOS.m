clear all;
close all;
clc;

%% CREATE SAMPLES
t = logspace(-3,log10(pi*10),1001);
% t = linspace(0,pi*10,1001);
L = 1 + (sin(t)).^2;

plot(t,L,'-ko','LineWidth',2,'MarkerSize',3)

Lmean_unif = mean(L);
Lmean = trapz(t,L)/(t(end)-t(1));

disp(['The mean value based on'...
    'uniformly distributed sample assumption:    ' ...
    num2str(Lmean_unif)])
disp(['The mean value based on'...
    'uniformly distributed sample assumption:    ' ...
    num2str(Lmean)])