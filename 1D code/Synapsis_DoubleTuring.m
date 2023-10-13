clear all
close all
for repeat=1
    repeat
    ToPlot=1;
    ToSave=0;
    test=0;
    n=150;
    
    t_min=0;
    t_max=600;
    
    %U1 & V1 Fast Turing patterning with many spikes
    %U2 & V2 Slow Turing pattering with crossover pattern
    
    %parameters ={DU1    , DV1  , MuU1  , MuV1  , DU2    , DV2  , MuU2    , MuV2  , r1  , rho1, V1V1 , r2, , rho2 , V2V2 , U1U2        , V1U2 , U2U1  , V2U1  , TimeScale1  ,TimeScale2,tStar,max decay rate}
    parameters = [0.0182 , 3.8  , -3.7  , -4.8  , 0.1   , 17   , -1.6    , -1.1  , 0.8 , 0.8 , 0    , 0.8 , 0.8 , 0     , 0.001*4    , 0    ,-0.3    , -0.7     , 1        ,.1 ,140,5];
    Da=.2;            %diffusion constant on activator          Da=0.2;
    Dh=18;            %diffusion constant on inhibitor         Dh=20;
    r=.8;             %growth rate                             r=.9;
    mu_a=1.7;         %degradation of activator                mu_a=1.7;
    mu_h=1.2;          %degradation of inhibitor               mu_h=1.2;
    rho = 0.8;         %                                 rho = 0.8;
    
    
    Init_U1=0.6;      %initial value of activator               Init_a=0.6;
    Init_V1=0.5;       %initial value of inhibitor              Init_h=0.5;
    Init_U2=0.6;      %initial value of activator               Init_a=0.6;
    Init_V2=0.5;       %initial value of inhibitor              Init_h=0.5;
    %spikes=1;         %number of spikes in forcing function
    %amp=0.00;         %amplitude of the forcing function. Set to zero for no forcing function
    x_min=-2.963;
    x_max=2.963;
    
    %%Initialization
    dx=(x_max-x_min)./n;
    x=x_min:dx:x_max-dx;
    Nx=length(x);
    Timecourse = zeros(t_max+1,Nx*4);
    
    
    %%Initial conditions
    noise=0.001;
    U1_in=Init_U1.*ones(1,Nx)+unifrnd(-noise,noise,1,Nx);
    V1_in=Init_V1.*ones(1,Nx)+unifrnd(-noise,noise,1,Nx);
    U2_in=Init_U2.*ones(1,Nx)+unifrnd(-noise,noise,1,Nx);
    V2_in=Init_V2.*ones(1,Nx)+unifrnd(-noise,noise,1,Nx);
    
    
    
    y0=[U1_in V1_in U2_in V2_in];
    if ToPlot
        Synapsis_DoubleTuring_plotting(x,y0,0)
    end
    Timecourse(1,:)=y0;
    for i=1:t_max*2
        tspan=[(i-1)/2. i/2.];
        [t,y]=ode45(@(t,y)Synapsis_DoubleTuring_GMlogisticODE(t,y,parameters,Nx,dx,test),tspan,y0);
        y0=[y(end,1:Nx) y(end,Nx+1:2*Nx) y(end,2*Nx+1:3*Nx) y(end,3*Nx+1:4*Nx)];
        if 0==mod(i,10)&&ToPlot
            Synapsis_DoubleTuring_plotting(x,y0,i)
        end
        if 0==mod(i,2)
            Timecourse(i/2+1,:)=y0;
        end
    end
    %
    
    if ToSave
        close all
        figure('Visible','off')
        subplot(1,2,1)
        plot(x,Timecourse(end,1:Nx),x,Timecourse(end,Nx+1:2*Nx))
        title(num2str(repeat))
        legend('U_1','V_1')
        subplot(1,2,2)
        plot(x,Timecourse(end,2*Nx+1:3*Nx),x,Timecourse(end,3*Nx+1:4*Nx))
        title(num2str(repeat))
        legend('U_2','V_2')
        saveas(gcf,['test/' num2str(repeat) '.png'])
        close all
        Synapsis_DoubleTuring_Visual(Nx,x,Timecourse,repeat);
        close all
    end
end