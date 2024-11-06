clear all;
close all;
clc;

%% problem definition
% 2D domain size [m^2]
A = 76;

% number of cells
N = [inf, 18000, 8000, 4500];

% representative cell size
h = sqrt(A./N);

% reattachment length
f = [0, 6.063, 5.972, 5.863];

% order of convergence
p = 1.53;

%% computations
% refinement ratios
r32 = h(4)/h(3);
r21 = h(3)/h(2);

f(1) = ( r21^p*f(2) - f(3) )/( r21^p-1 );

eps32 = abs( (f(4)-f(3))/f(3) );
eps21 = abs( (f(3)-f(2))/f(2) );

GCI21 = 1.25*eps21/(r21^p-1);
GCI32 = 1.25*eps32/(r32^p-1);

AR = r21^p*GCI21/GCI32;


%% visualisation
figure(1)
plot(h(2:end)/h(2),f(2:end),'-ko','LineWidth',2,'MarkerFaceColor','black')
hold on
plot(h(1:2)/h(2),f(1:2),'r--','LineWidth',2)
plot(h(1),f(1),'rd','MarkerSize',8,'MarkerFaceColor','red')
xlabel('Normalised grid spacing')
ylabel('Reattachment length')

