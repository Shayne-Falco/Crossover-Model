close all
clear all
% Using an explicit method to solve the Gierer-Meinhardt model on a 1D
% domain with periodic boundary conditions
sweep=[.2 .4 .6 .8 1 1.2 1.4 1.6 1.8 2];
for d=1
    for k=5
        for l=7
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
            spikes=1;      %number of spikes in forcing function
            amp=0.00;      %amplitude of the forcing function. Set to zero for no forcing function
            
            dx=0.1;
            if d==1
                x_min=-39.63;
                x_max=39.63;
            else
                x_min=-48.54;  %Area of 750
                x_max=48.54;
            end
            t_min=0;
            t_max=300;
            
            if k==1
                Da=Da*sweep(l);
            elseif k==2
                Dh=Dh*sweep(l);
            elseif k==3
                rho=rho*sweep(l);
            elseif k==4
                mu_a=mu_a*sweep(l);
            else
                mu_h=mu_h*sweep(l);
            end
            run=sprintf('sweep2/Da=%f,Dh=%f,rho=%f,mu_a=%f,mu_h=%f,size=%f',Da,Dh,rho,mu_a,mu_h,x_max*2)
            mkdir(run);
            %%Initialization
            x=x_min:dx:x_max-dx;
            Nx=length(x);
            
            %%Initial conditions
            A_in=Init_a.*ones(Nx,1)+unifrnd(-0.0005,0.0005,Nx,1);
            H_in=Init_h.*ones(Nx,1);
            
            y0=[A_in H_in];
            tspan=[0 .5];
            [t,y]=ode45(@(t,y)myODE(t,y,dx,Da,Dh,rho,mu_a,mu_h,rho_a,rho_h,Nx,spikes,amp),tspan,y0);
            for i=1:t_max*2
                tspan=[i/2 (i+1)/2];
                y0=[y(end,1:Nx) y(end,Nx+1:end)];
                [t,y]=ode45(@(t,y)myODE(t,y,dx,Da,Dh,rho,mu_a,mu_h,rho_a,rho_h,Nx,spikes,amp),tspan,y0);
                if 0==mod(i,10)
                    figure('visible','off')
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
            figure('visible','off')
            plot(x,y(end,1:Nx),x,y(end,Nx+1:end))
            title(sprintf('Concentrationa at t=%d',t_max))
            print([run '/final'],'-dpng');
        end
    end
end