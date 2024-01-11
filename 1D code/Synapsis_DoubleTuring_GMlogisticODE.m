function dy=Synapsis_DoubleTuring_GMlogisticODE(t,y,parameters,Nx,dx,test)
%equaions from Song 2017 Pattern dynamics in a Gierer-Meinhardt model with
%a saturating term
y=y';
U1=y(2:Nx-1);       %U1 is 1:Nx
V1=y(Nx+2:2*Nx-1);   %V1 is Nx+1:2*Nx
U2=y(2*Nx+2:3*Nx-1);       %U2 is 2*Nx+1:3*Nx
V2=y(3*Nx+2:4*Nx-1);   %V2 is 3*Nx+1:4*Nx
%               1     2      3      4     5     6      7      8        9     10     11   12      13     14     15     16     17     18,  19       ,   20      ,21    ,22
%parameters ={DU1 , DV1 , MuU1  , MuV1  , DU2 , DV2 , MuU2  , MuV2  , r1  , rho1, V1V1 , r2, , rho2 , V2V2 , U1U2 , V1U2 , U2U1 , V2U1, TimeScale1,TimeScale2, tStar,decay}

function y=timeDecay(t,tp,decay)
    if t<tp-50 || t==tp
        y=0;
    elseif (t>tp-50) && (t<tp+100)
        y=(decay/150)*(t-(tp-50));
    else
        y=decay;
    end
end

U1_xp1=[U1(2:end) y(Nx)];
V1_xp1=[V1(2:end) y(2*Nx)];
U1_xm1=[y(1) U1(1:end-1)];
V1_xm1=[y(Nx+1) V1(1:end-1)];

U2_xp1=[U2(2:end) y(3*Nx)];
V2_xp1=[V2(2:end) y(4*Nx)];
U2_xm1=[y(2*Nx+1) U2(1:end-1)];
V2_xm1=[y(3*Nx+1) V2(1:end-1)];

%U1 1:Nx
dy(2:Nx-1)=(parameters(9).*((U1.^2)./((1+parameters(10).*U1.^2).*V1)    +  parameters(3).*U1)       + ...
    parameters(1).*(U1_xp1-2.*U1+U1_xm1)./(dx^2) + parameters(17)*U1.*U2 + parameters(18)*U1.*V2);

dy(1)=     (parameters(9).*((y(1).^2)./((1+parameters(10).*y(1).^2).*y(Nx+1))   +  parameters(3).*y(1))    +...
    parameters(1).*(y(2)-y(1))./(dx^2)  + parameters(17)*y(1).*y(2*Nx+1) + parameters(18)*y(1).*y(3*Nx+1));

dy(Nx)=    (parameters(9).*((y(Nx).^2)./((1+parameters(10).*y(Nx).^2).*y(2*Nx))   +  parameters(3).*y(Nx))   +...
    parameters(1).*(y(Nx-1)-y(Nx))./(dx^2)  + parameters(17)*y(Nx).*y(3*Nx) + parameters(18)*y(Nx).*y(4*Nx));


%V1 Nx+1:2*Nx
dy(Nx+2:2*Nx-1)=(parameters(9).*(U1.^2       +  parameters(4).*V1)   +parameters(11).*V1.*V1     +...
    parameters(2).*(V1_xp1-2.*V1+V1_xm1)./(dx^2));

dy(Nx+1)=       (parameters(9).*(y(1).^2    +  parameters(4).*y(Nx+1)) +parameters(11).*y(Nx+1).*y(Nx+1) +...
    parameters(2).*(y(Nx+2)-y(Nx+1))./(dx^2));

dy(2*Nx)=       (parameters(9).*(y(Nx).^2   +  parameters(4).*y(2*Nx))  +parameters(11).*y(2*Nx).*y(2*Nx) +...
    parameters(2).*(y(2*Nx-1)-y(2*Nx))./(dx^2));

dy(1:2*Nx)=(dy(1:2*Nx)-timeDecay(t,parameters(21),parameters(22)).*y(1:2*Nx))*parameters(19);


%U2 2*Nx+1:3*Nx
dy(2*Nx+2:3*Nx-1)= (parameters(12).*((U2.^2)./((1+parameters(13).*U2.^2).*V2)    +  parameters(7).*U2)   +parameters(15).*U1.*U2    + ...
    parameters(16).*V1.*U2  +  parameters(5).*(U2_xp1-2.*U2+U2_xm1)./(dx^2));


dy(2*Nx+1)=     (parameters(12).*((y(2*Nx+1).^2)./((1+parameters(13).*y(2*Nx+1).^2).*y(3*Nx+1))    +  parameters(7).*y(2*Nx+1))   +parameters(15).*y(1).*y(2*Nx+1)    + ...
    parameters(16).*y(2*Nx+1).*y(Nx+1)  +  parameters(5).*(y(2*Nx+2)-y(2*Nx+1))./(dx^2));

%                   r2       *((U2^2        / (1+rho2           *U2^2     )*V2       +              mu*U2          )   +  U1U2             *U1*U2            +
dy(3*Nx)=    (parameters(12).*((y(3*Nx).^2)./((1+parameters(13).*y(3*Nx).^2).*y(4*Nx))    +  parameters(7).*y(3*Nx))   +parameters(15).*y(Nx).*y(3*Nx)   + ...
    parameters(16).*y(2*Nx).*y(3*Nx)  +  parameters(5).*(y(3*Nx-1)-y(3*Nx))./(dx^2));
%    V1U2          *V1      *U2       +  DU2 *([U2-1]-U2)/dx^2

%V2 3*Nx+1:4*Nx
dy(3*Nx+2:4*Nx-1)=(parameters(12).*(U2.^2       +  parameters(8).*V2)     +parameters(14).*V2.*V2   +...
    parameters(6).*(V2_xp1-2.*V2+V2_xm1)./(dx^2));

dy(3*Nx+1)=       (parameters(12).*(y(2*Nx+1).^2    +  parameters(8).*y(3*Nx+1)) +parameters(14).*y(3*Nx+1).*y(3*Nx+1) +...
    parameters(6).*(y(3*Nx+2)-y(3*Nx+1))./(dx^2));

dy(4*Nx)=       (parameters(12).*(y(3*Nx).^2   +  parameters(8).*y(4*Nx)) +parameters(14).*y(4*Nx)^2  +...
    parameters(6).*(y(4*Nx-1)-y(4*Nx))./(dx^2));

dy(2*Nx+1:4*Nx)=dy(2*Nx+1:4*Nx)*parameters(20);


%if t==90
%    dy
%end
if test
    ToStop=0;
    
    if sum(y(1:Nx) - y(2*Nx+1:3*Nx))~=0
        ToStop=1;
        disp('U')
        disp(y(1:Nx) - y(2*Nx+1:3*Nx))
    end
    
    if sum(y(Nx+1:2*Nx) - y(3*Nx+1:4*Nx))~=0
        ToStop=1;
        disp('V')
        disp(y(Nx+1:2*Nx) - y(3*Nx+1:4*Nx))
    end
    if ToStop
        stop
    end
end

dy=dy';
end