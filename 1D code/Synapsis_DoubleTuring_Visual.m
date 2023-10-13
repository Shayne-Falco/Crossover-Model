function [] = Synapsis_DoubleTuring_Visual(Nx,x,data,repeat)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
close all
U1=data(:,1:Nx);
V1=data(:,Nx+1:2*Nx);
U2=data(:,2*Nx+1:3*Nx);
V2=data(:,3*Nx+1:4*Nx);

space=1;
Umin=min(min(min(U1,U2)));
Vmin=min(min(min(V1,V2)));
Umax=max(max(max(U1,U2)));
Vmax=max(max(max(V1,V2)));

U1=U1-Umin;
V1=V1-Vmin;
U1=U1/Umax;
V1=V1/Vmax;

U2=U2-Umin;
V2=V2-Vmin;
U2=U2/Umax;
V2=V2/Vmax;
%min(min(A))

s=size(data);
n=1;
i=1;

vidfile = VideoWriter(['test/' num2str(repeat) 'testmovie.avi']);
open(vidfile);
figure('Visible','off')
Synapsis_DoubleTuring_plotting(x,[U1(1,:) V1(1,:) U2(1,:) V2(1,:)],0)
% for j = 1:Nx
%     fill([j-1,j,j,j-1],[0,0,1,1],[U1(i,j) U1(i,j) U1(i,j)],'edgecolor','none')
%     hold on
% end
% for j = 1:Nx
%     fill([j-1,j,j,j-1],[2,2,3,3],[U2(i,j) U2(i,j) U2(i,j)],'edgecolor','none')
%     hold on
% end
title(sprintf('t=%d',i-1))
%axis([0 Nx 0 3])
%set(gca,'ytick',[])
%pbaspect([8 1 1])
loops=length(1:space:s(1));
ax = gca;
ax.NextPlot = 'replaceChildren';
F(loops) = struct('cdata',[],'colormap',[]);
for i=space:space:s(1)
    %     for j = 1:Nx
    %         fill([j-1,j,j,j-1],[0,0,1,1],[U1(i,j) U1(i,j) U1(i,j)],'edgecolor','none')
    %         hold on
    %     end
    %
    %     for j = 1:Nx
    %         fill([j-1,j,j,j-1],[2,2,3,3],[U2(i,j) U2(i,j) U2(i,j)],'edgecolor','none')
    %         hold on
    %     end
    Synapsis_DoubleTuring_plotting(x,[U1(i,:) V1(i,:) U2(i,:) V2(i,:)],i*2)
    %title(sprintf('t=%d',i-1))
    %axis([0 Nx 0 3])
    %set(gca,'ytick',[])
    %pbaspect([8 1 1])
    F(n) = getframe(gcf);
    writeVideo(vidfile,F(n));
    n=n+1;
    
end

close(vidfile)