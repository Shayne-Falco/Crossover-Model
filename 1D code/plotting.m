function []= plotting(x,y,i)
%PLOTTING plots the G_M.m code with activator and inhibitor
%   Detailed explanation goes here

plotOffset=0;
Nx=length(x);
y1=y(end,1:Nx);
y1_min=min(y1);
y1_max=max(y1);
y2=y(end,Nx+1:end);
y2_min=min(y2);
y2_max=max(y2);
figure(1)
subplot(1,2,1)
plot(x,y1)
title(sprintf('Concentration of U at t=%d',(i-1)/2))
axis([x(1),x(end),y1_min-plotOffset,y1_max+plotOffset])
subplot(1,2,2)
plot(x,y2)
title(sprintf('Concentration of V at t=%d',(i-1)/2))
axis([x(1),x(end),y2_min-plotOffset,y2_max+plotOffset])
drawnow()

end

