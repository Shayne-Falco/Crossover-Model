close all
clear all
% Using an explicit method to solve the Gierer-Meinhardt model on a 1D
% domain with periodic boundary conditions

%%Parameters
Da=0.94;          %diffusion constant on activator
Dh=54;          %diffusion constant on inhibitor
rho=.2;         %growth rate
mu_a=.21;      %degradation of activator
mu_h=.6;      %degradation of inhibitor
rho_a=.003;    %basal growth of activator
rho_h=0.0001;    %basal growth of inhibitor
Init_a=2.94;      %initial value of activator
Init_h=2.9;   %initial value of inhibitor
%Forcing equation parameters

Amp=.0001; %set to zero for no forcing function

dx=0.1;
% x_min=-39.63;  %Area of 550
% x_max=39.63;
x_min=-48.54;  %Area of 750
x_max=48.54;
t_min=0;
t_max=300;
Amps=[0.00001 0.00002 0.0001 0.0002 0.0005 0.001];
figure('visible','off')
for j=1:length(Amps)
    Amp=Amps(j);
    for spikes=1:4
        run=sprintf('Forcing/spikes=%d/Amp=%f/domain=%f',spikes,Amp,2*x_max);
        mkdir(run);
        %%Initialization
        x=x_min:dx:x_max-dx;
        Nx=length(x);
        
        %%Initial conditions
        A_in=Init_a.*ones(Nx,1)+unifrnd(-0.0005,0.0005,Nx,1);
        H_in=Init_h.*ones(Nx,1);
        
        y0=[A_in H_in];
        tspan=[0 .5];
        [t,y]=ode45(@(t,y)myODE(t,y,dx,Da,Dh,rho,mu_a,mu_h,rho_a,rho_h,Nx,spikes,Amp),tspan,y0);
        for i=1:t_max*2
            tspan=[i/2 (i+1)/2];
            y0=[y(end,1:Nx) y(end,Nx+1:end)];
            [t,y]=ode45(@(t,y)myODE(t,y,dx,Da,Dh,rho,mu_a,mu_h,rho_a,rho_h,Nx,spikes,Amp),tspan,y0);
            if 0==mod(i,10)
                subplot(1,2,1)
                plot(x,y(end,1:Nx))
                title(sprintf('Concentration of A at t=%d',i/2))
                axis([x_min,x_max,-inf,inf])
                subplot(1,2,2)
                plot(x,y(end,Nx+1:end))
                title(sprintf('Concentration of H at t=%d',i/2))
                axis([x_min,x_max,-inf,inf])
                drawnow()
                print([run sprintf('/t=%d',i/2)],'-dpng');
            end
        end
        % figure()
        % surf(x,t,y(:,1:Nx), 'linestyle', 'none');
        % title('concentration of A over time');
        % figure()
        % surf(x,t,y(:,Nx+1:end), 'linestyle', 'none');
        % title('concentration of H over time');
        subplot(1,2,1:2)
        plot(x,y(end,1:Nx),x,y(end,Nx+1:end))
        title(sprintf('Concentrationa at t=%d',t_max))
        print([run '/final'],'-dpng');
    end
end

