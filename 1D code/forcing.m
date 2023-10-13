function I=forcing(Nx,spikes,L,A)
k=linspace(0,2*L,Nx);
I=A.*sin(k.*(pi*spikes/L));
I(I<0)=0;