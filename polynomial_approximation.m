clear all;
close all;
clc;

N = 2.^[1,2,3,4,5,6];
val = 0*N;

for i = 1:length(N)
    x = linspace(0,1,N(i));
    y = x.^2;
    
    val(i) =  trapz(x,y);

    plot(x,y,'-ko','LineWidth',2,'MarkerFaceColor','k')
    pause(2)
end


figure(2)
plot(1./N,val,'b--o');
