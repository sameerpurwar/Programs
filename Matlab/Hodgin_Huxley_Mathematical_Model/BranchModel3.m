%% Potential along the tree (not by simultaneous solving and  original Hud-Hux model)
%% Enter the input

iter = input('enter the iteration(time in milli second): ');
I    = input('enter the impulse current in nanoAmpere: ');

%% defining function

alpha_n = @(V) 0.01*(10 - V)/(exp((10-V)/10) - 1);
alpha_m = @(V) 0.1*(25 - V)/(exp((25-V)/10) - 1);
alpha_h = @(V) 0.07*exp(-V/20);

beta_n = @(V) 0.125*exp(-V/80);
beta_m = @(V) 4*exp(-V/18);
beta_h = @(V) 1/(exp((30-V)/10) + 1);


%% Initializing the values

V = zeros(5,iter); 

m = zeros(iter,5);
h = zeros(iter,5);
n = zeros(iter,5);

a1 = 0.0338;
a2 = 0.0138; 
a3 = 0.0138;

I0 = 0;
dx = 0.25;
R = 0.034;
C = 1;
dt = 0.01;

g_Na = 120;
g_K  = 36;
g_L  = 0.3;

V_Na = 115;
V_K  = -12;
V_L  = 10.6;

%% initializing resting voltage
V(:,1) = [0,0,0,0,0]';

m(1,:) = [0.5,0.2,0.1,0.1,0.1];
h(1,:) = [0.5,0.5,0.3,0.3,0.3];
n(1,:) = [0.2,0.2,0.2,0.2,0.2];

%% Backward Euler
 
for t = 1:iter
	for x = 1:5

		G_na = g_Na * m(t,x)^3 * h(t,x);
		G_k  = g_K * n(t,x)^4;
		G_l  = g_L;

		n(t+1,x) = n(t,x) + dt*( (alpha_n(V(x,t))*(1-n(t,x))) - (beta_n(V(x,t))* n(t,x)) );
		m(t+1,x) = m(t,x) + dt*( (alpha_m(V(x,t))*(1-m(t,x))) - (beta_m(V(x,t))* m(t,x)) );
		h(t+1,x) = h(t,x) + dt*( (alpha_h(V(x,t))*(1-h(t,x))) - (beta_h(V(x,t))* h(t,x)) );

		if(x == 1)
			V(1,t+1) = (G_k*V_K + G_l*V_L + G_na*V_Na + (C*V(1,t))/dt + (R*V(2,t)*a1*dx^2)/2 + (I0*pi*a1*dx*t^2*exp(-10*t))/2)/((R*a1*dx^2)/2 + G_k + G_l + G_na + C/dt);

		elseif(x == 2)
			V(2,t+1) = ((R*a1*(V(1,t) + V(3,t))*dx^2)/2 + G_k*V_K + G_l*V_L + G_na*V_Na + (C*V(2,t))/dt)/(R*a1*dx^2 + G_k + G_l + G_na + C/dt);

		elseif(x == 3)
			V(3,t+1) = (V(2,t)*a1^2 + V(4,t)*a2^2 + V(5,t)*a3^2)/(a1^2 + a2^2 + a3^2);

		elseif(x == 4)
			V(4,t+1) = (G_k*V_K + G_l*V_L + G_na*V_Na + (C*V(4,t))/dt - (R*V(3,t)*a2*dx^2)/2)/(G_k + G_l + G_na + C/dt - (R*a2*dx^2)/2);

		else
			V(5,t+1) = (G_k*V_K + G_l*V_L + G_na*V_Na + (C*V(5,t))/dt - (R*V(3,t)*a3*dx^2)/2)/(G_k + G_l + G_na + C/dt - (R*a3*dx^2)/2);
		end
	end
end

%%

figure
subplot(2,3,1)
plot(V(1,:))
grid on
title('at position 1')

subplot(2,3,2)
plot(V(2,:))
grid on
title('at position 2')

subplot(2,3,3)
plot(V(3,:))
grid on
title('at position 3')

subplot(2,3,4)
plot(V(4,:))
grid on
title('at position 4')

subplot(2,3,5)
plot(V(5,:))
grid on
title('at position 5')