function [] = synapsisVisual(Nx,data)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
A=data(:,1:Nx);
H=data(:,Nx+1:end);

space=1;

A=A-min(min(A));
H=H-min(min(H));
A=A/max(max(A));
H=H/max(max(H));
%min(min(A))

s=size(data);
n=1;
i=1;

vidfile = VideoWriter('testmovie.avi');
open(vidfile);
figure('Visible','off') 
for j = 1:Nx
    fill([j-1,j,j,j-1],[0,0,1,1],[A(i,j) A(i,j) A(i,j)],'edgecolor','none')
    hold on
end
title(sprintf('t=%d',i-1))
axis([0 Nx 0 1])
set(gca,'ytick',[])
pbaspect([8 1 1])
loops=length(1:space:s(1));
ax = gca;
ax.NextPlot = 'replaceChildren';
F(loops) = struct('cdata',[],'colormap',[]);
for i=space:space:s(1)
    for j = 1:Nx
        fill([j-1,j,j,j-1],[0,0,1,1],[A(i,j) A(i,j) A(i,j)],'edgecolor','none')
        hold on
    end
    title(sprintf('t=%d',i-1))
    axis([0 Nx 0 1])
    set(gca,'ytick',[])
    pbaspect([8 1 1])
    F(n) = getframe(gcf);
    writeVideo(vidfile,F(n));
    n=n+1;
    
end

close(vidfile)