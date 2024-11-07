clear all;
close all;
clc;

%% physical and computational parameter
x0 = 0.0;
x1 = 1.0;
f = 1.0;
right_Neumann_BC = 0;

% mesh generation
N = 21;
dx = (x1-x0)/(N-1);
x = linspace(x0, x1, N);

Nt = 4000;
CFL = 0.4;
dt = CFL * dx^2;


%% time marching
t = pi/2;
u_old = cos(x)*sin(t);
u_new = cos(x)*sin(t);

% set(0,'DefaultFigureVisible','off');
cter = 0;
pic_cter = 0;
for i = 1:Nt
    u_old(1) = cos(x0)*sin(t);
    u_old(end) = cos(x1)*sin(t);
    u_new(1) = cos(x0)*sin(t);
    u_new(end) = cos(x1)*sin(t);

    u_new(2:end-1) = u_old(2:end-1) + ...
        dt/dx^2*( u_old(1:end-2) - 2*u_old(2:end-1) + u_old(3:end) ) - ...
        f*dt + dt*( cos(x(2:end-1))*cos(t) + cos(x(2:end-1))*sin(t) + f);

    u_old = u_new;
    u_analyt = cos(x)*sin(t);

    t = t + dt;

    if mod(cter,10)==0
        figure('Visible', 'off');
        plot(x,u_new,'-k','LineWidth',2,'MarkerFaceColor','k');
        hold on
        plot(x,u_analyt,':r','LineWidth',2,'MarkerFaceColor','k');
        xlim([x0,x1])
        ylim([-1,1])
        xlabel('x')
        ylabel('u')
        fID = sprintf( '%05d', pic_cter );
        saveas(gcf,['pic/pic' fID '.png'])
        pic_cter = pic_cter+1
    end
    cter = cter+1;
end

%% postprocessing
% figure(1)
% hold on
% plot(x,u_num_dir,'-k','LineWidth',2,'MarkerFaceColor','k');
% plot(x_analyt,u_analyt,':r','LineWidth',2)
% plot(x,u_num_ind,'b+','LineWidth',2,'MarkerFaceColor','b','MarkerSize',8)
% xlabel('x')
% ylabel('u')