function []= Synapsis_DoubleTuring_plotting(x,y,i)
%PLOTTING plots the G_M.m code with activator and inhibitor
%   Detailed explanation goes here

plotOffset=0;
Nx=length(x);
y1=y(end,1:Nx);
y1_min=min(y1);
y1_max=max(y1);
y2=y(end,Nx+1:2*Nx);
y2_min=min(y2);
y2_max=max(y2);

y3=y(end,2*Nx+1:3*Nx);
y3_min=min(y3);
y3_max=max(y3);
y4=y(end,3*Nx+1:4*Nx);
y4_min=min(y4);
y4_max=max(y4);


subplot(2,2,1)
plot(x,y1)
title(sprintf('[A1] at t=%d',(i)/2))
axis([x(1),x(end),y1_min-plotOffset,y1_max+plotOffset])
subplot(2,2,2)
plot(x,y2)
title(sprintf('[H1] at t=%d',(i)/2))
axis([x(1),x(end),y2_min-plotOffset,y2_max+plotOffset])
drawnow()

subplot(2,2,3)
plot(x,y3)
title(sprintf('[A2] at t=%d',(i)/2))
axis([x(1),x(end),y3_min-plotOffset,y3_max+plotOffset])
subplot(2,2,4)
plot(x,y4)
title(sprintf('[H2] at t=%d',(i)/2))
axis([x(1),x(end),y4_min-plotOffset,y4_max+plotOffset])
drawnow()

end

