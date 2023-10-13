function I=Initial(Nx,spikes,L,A)
k=linspace(0,2*L,Nx);
I=.005.*sin(k.*(pi*spikes/L))+A;
