clear all;
close all;
clc;

%% physical and computational parameter
x0 = -5.0;
x1 = 10.0;
f = 1.0;
u0 = 0; % left boundary condition
u1 = 1; % right boundary condition
right_Neumann_BC = 0;

N = 6;

% mesh generation
dx = (x1-x0)/(N-1);
x = linspace(x0, x1, N);


%% Construct analytical solution
N_analyt = 1001;
x_analyt = linspace(x0,x1,N_analyt);
dx_analyt = (x1-x0)/(N_analyt-1);
C2 = f/2;
C1 = (u0-u1 - C2*(x0^2-x1^2) )/(x0-x1);
C0 = u0 - C2*x0^2 - C1*x0;

u_analyt = C2*x_analyt.^2 + C1*x_analyt + C0;

%% Construct and solve matrix form of the linear system
A = eye(N);
b = zeros(N,1);

A(2:end-1,2:end-1) = -2/dx^2 * A(2:end-1,2:end-1);
for i=2:N-1
    for j=1:N
        if j==i-1
            A(i,j) = 1/dx^2;
        end
        if j==i+1
            A(i,j) = 1/dx^2;
        end
    end
end

if right_Neumann_BC==1
    A(end,end-1) = -1;
end

b(1) = u0;
b(2:end-1) = f;
b(end) = u1;

u_num_dir = A\b;

%% Solve problem iteratively
u_old = zeros(1,N);
u_new = zeros(1,N);

u_old(1) = u0;
u_old(end) = u1;
u_new(1) = u0;
u_new(end) = u1;

CFL = 0.1;
dt = CFL * dx^2;
change = 1e8;
cter = 1;

tolerance = 1e-25;
max_iter = 30000;

residual = [0,0];

while change > tolerance && cter<max_iter
    u_new(2:end-1) = u_old(2:end-1) + ...
        dt/dx^2*( u_old(1:end-2) - 2*u_old(2:end-1) + u_old(3:end) ) - ...
        f*dt;

    change = max(abs(u_new-u_old));
    disp([cter change])
    residual(cter,1) = cter;
    residual(cter,2) = change;

    u_old = u_new;
    cter = cter + 1;
end
u_num_ind = u_new;

%% postprocessing
figure(1)
hold on
plot(x,u_num_dir,'-k','LineWidth',2,'MarkerFaceColor','k');
plot(x_analyt,u_analyt,':r','LineWidth',2)
plot(x,u_num_ind,'b+','LineWidth',2,'MarkerFaceColor','b','MarkerSize',8)
xlabel('x')
ylabel('u')

d2udx2_analyt = gradient(gradient(u_analyt,dx_analyt),dx_analyt);
d2udx2_num1 = gradient(gradient(u_num_dir,dx),dx);

figure(9)
plot(residual(:,1),residual(:,2),'-k','linewidth',2)
xlabel('Iterations')
ylabel('Maximum change between consecutive time steps')