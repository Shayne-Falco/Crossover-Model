function []= Synapsis_DoubleTuring_plotting(x,y,i)
%PLOTTING plots the G_M.m code with activator and inhibitor
%   Detailed explanation goes here

plotOffset=0;
Nx=length(x);
y1=y(end,1:Nx);
y1_min=min(y1);
y1_max=max(max(y1),1);
y2=y(end,Nx+1:2*Nx);
y2_min=min(y2);
y2_max=max(y2);

y3=y(end,2*Nx+1:3*Nx);
y3_min=min(y3);
y3_max=max(max(y3),1);
y4=y(end,3*Nx+1:4*Nx);
y4_min=min(y4);
y4_max=max(y4);


subplot(2,2,1)
plot(x,y1)
title('Activator (DSB)')
axis([x(1),x(end),0,y1_max])
subplot(2,2,2)
plot(x,y2)
title('Inhibitor (DSB)')
axis([x(1),x(end),0,1])
drawnow()

subplot(2,2,3)
plot(x,y3)
title('Activator (Crossover)')
axis([x(1),x(end),0,y3_max])
subplot(2,2,4)
plot(x,y4)
title('Inhibitor (Crossover)')
axis([x(1),x(end),0,1])
sgtitle(sprintf('t=%d',(i)/2))
drawnow()

end

