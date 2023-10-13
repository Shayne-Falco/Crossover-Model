function dy=GMlogisticODE(~,y,dx,Da,Dh,r,mu_a,mu_h,rho,Nx)
%equaions from Song 2017 Pattern dynamics in a Gierer-Meinhardt model with
%a saturating term
y=y';
A=y(2:Nx-1);       %A is 1:Nx
H=y(Nx+2:end-1);   %H is Nx+1:2*Nx


A_xp1=[A(2:end) y(Nx)];
H_xp1=[H(2:end) y(end)];
A_xm1=[y(1) A(1:end-1)];
H_xm1=[y(Nx+1) H(1:end-1)];


dy(2:Nx-1)=(r.*((A.^2)./((1+rho.*A.^2).*H)    -  mu_a.*A)       + ...
    Da.*(A_xp1-2.*A+A_xm1)./(dx^2));

dy(1)=     (r.*((y(1).^2)./((1+rho.*y(1).^2).*y(Nx+1))   -  mu_a.*y(1))    +...
    Da.*(y(2)-y(1))./(dx^2));
dy(Nx)=    (r.*((y(Nx).^2)./((1+rho.*y(Nx).^2).*y(end))   -  mu_a.*y(Nx))   +...
    Da.*(y(Nx-1)-y(Nx))./(dx^2));



dy(Nx+2:2*Nx-1)=(r.*(A.^2       -  mu_h.*H)        +...
    Dh.*(H_xp1-2.*H+H_xm1)./(dx^2));

dy(Nx+1)=       (r.*(y(1).^2    -  mu_h.*y(Nx+1))  +...
    Dh.*(y(Nx+2)-y(Nx+1))./(dx^2));
dy(2*Nx)=       (r.*(y(Nx).^2   -  mu_h.*y(end))   +...
    Dh.*(y(2*Nx-1)-y(2*Nx))./(dx^2));

dy=dy';