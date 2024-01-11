function dy=GMperiodicODE(~,y,dx,Da,Dh,rho,mu_a,mu_h,rho_a,rho_h,Nx)

A=y(1:Nx)';
H=y(Nx+1:end)';
A_xp1=[A(2:end) A(1)];
H_xp1=[H(2:end) H(1)];
A_xm1=[A(end) A(1:end-1)];
H_xm1=[H(end) H(1:end-1)];
dy(1:Nx)=(rho.*((A.^2)./H)   -  mu_a.*A   +   Da.*(A_xp1-2.*A+A_xm1)./(dx^2)  +   rho_a.*ones(1,Nx));
dy(Nx+1:2*Nx)=(rho.*(A.^2)   -  mu_h.*H   +   Dh.*(H_xp1-2.*H+H_xm1)./(dx^2)  +   rho_h.*ones(1,Nx));


dy=dy';