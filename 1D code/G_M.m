clear all
close all


ToPlot=0;
logistic=1;

n=150;

t_min=0;
t_max=20;

% %%Parameters
if logistic       %%%%Synapsis with zero flux boundary conditions
    
    Da=.2;          %diffusion constant on activator          Da=0.2;
    Dh=18;            %diffusion constant on inhibitor         Dh=20;
    r=.8;             %growth rate                             r=.9;
    mu_a=1.7;         %degradation of activator                mu_a=1.7;
    mu_h=1.2;          %degradation of inhibitor               mu_h=1.2;
    rho = 0.8;         %                                 rho = 0.8;
    Init_a=0.6;      %initial value of activator               Init_a=0.6;
    Init_h=0.5;       %initial value of inhibitor              Init_h=0.5;
    x_min=-2.963;
    x_max=2.963;
else               %%%%Periodic boundary conditions
    Da=0.94*2;          %diffusion constant on activator
    Dh=54;          %diffusion constant on inhibitor
    rho=.2;         %growth rate
    mu_a=.21;      %degradation of activator
    mu_h=.6;      %degradation of inhibitor
    rho_a=.003;    %basal growth of activator
    rho_h=0.0001;    %basal growth of inhibitor
    Init_a=2.94;      %initial value of activator
    Init_h=2.9;   %initial value of inhibitor
    x_min=-3.963*10;
    x_max=3.963*10;
end


%%Initialization
dx=(x_max-x_min)./n;
x=x_min:dx:x_max-dx;
Nx=length(x);
Timecourse = zeros(t_max+1,Nx*2);


%%Initial conditions
H_in=Init_h.*ones(1,Nx)+unifrnd(-0.05,0.05,1,Nx);
A_in=Init_a.*ones(1,Nx)+unifrnd(-0.05,0.05,1,Nx);



y0=[A_in H_in];
Timecourse(1,:)=y0;
for i=1:t_max*2
    tspan=[(i-1)/2. i/2.];
    if logistic
        [t,y]=ode45(@(t,y)GMlogisticODE(t,y,dx,Da,Dh,r,mu_a,mu_h,rho,Nx),tspan,y0);
    else
        [t,y]=ode45(@(t,y)GMperiodicODE(t,y,dx,Da,Dh,rho,mu_a,mu_h,rho_a,rho_h,Nx),tspan,y0);
    end
    y0=[y(end,1:Nx) y(end,Nx+1:end)];
    if 1==mod(i,20)&&ToPlot
        plotting(x,y,i)
    end
    if 0==mod(i,2)
        Timecourse(i/2+1,:)=y0;
        plot(x,y(end,1:Nx),x,y(end,Nx+1:end))
        %title(sprintf('t=%d',i/2))
        %axis([x_min,x_max,0,1])
        %subplot(1,2,2)
        %plot(x,y(end,Nx+1:end))
        %title(sprintf('[V]'))
        % axis([x_min,x_max,-inf,inf])
        legend('[U]','[V]')
        xlabel('SC')
        ylabel('Morphogen Concentration')
        drawnow()
    end
end
