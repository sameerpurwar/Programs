%% Potential along the tree (not by simultaneous solving)
close all;
clear 
%% Enter the input

iter = input('enter the iteration(time in milli second): ');
I0    = input('enter the impulse current in nanoAmpere: ');

%% defining function

alpha_n = @(V) 0.01*(10 - V)/(exp((10-V)/10) - 1);
alpha_m = @(V) 0.1*(25 - V)/(exp((25-V)/10) - 1);
alpha_h = @(V) 0.07*exp(-V/20);

beta_n = @(V) 0.125*exp(-V/80);
beta_m = @(V) 4*exp(-V/18);
beta_h = @(V) 1/(exp((30-V)/10) + 1);


%% Initializing the values

V = zeros(5,iter);

mh = zeros(2,4,5,iter);
n = zeros(5,5,iter);
%%
a1 = 0.0338;
a2 = 0.0138; 
a3 = 0.0138;

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
V(:,1) = [20,0,0,0,0];

for k = 1:5
mh(:,:,k,1) = [0,k/10,0,0.3+k/20 ;
			   0,0,0.5 - k/10,0.2+k/20];

n(:,k,1) = [0.2-k/30,0.3,0 - k/20.2,0 + k/30.3,0 + k/20];
end
%% Backward Euler 

for t =1:iter
for k = 1:5
	

	mh(1,4,k,t+1) = dt*( alpha_m(V(k,t))*mh(1,3,k,t)	+ alpha_h(V(k,t))*mh(2,4,k,t) - 3*beta_m(V(k,t))*mh(1,4,k,t) - beta_h(V(k,t))*mh(1,4,k,t)) + mh(1,4,k,t);

	mh(2,4,k,t+1) = dt*((beta_h(V(k,t))*mh(1,4,k,t) + alpha_m(V(k,t))*mh(2,3,k,t)) - 3*beta_m(V(k,t))*mh(2,4,k,t) - alpha_h(V(k,t))*mh(2,4,k,t)) + mh(2,4,k,t);

	mh(1,3,k,t+1) = dt*((alpha_h(V(k,t))*mh(2,3,k,t) + 3*beta_m(V(k,t))*mh(1,4,k,t) + 2*alpha_m(V(k,t))*mh(1,2,k,t)) - (alpha_m(V(k,t)) + 2*beta_m(V(k,t)) + beta_h(V(k,t)))*mh(1,3,k,t)) + mh(1,3,k,t);

	mh(2,3,k,t+1) = dt*((beta_h(V(k,t))*mh(1,3,k,t) + 3*beta_m(V(k,t))*mh(2,4,k,t) + 2*alpha_m(V(k,t))*mh(2,2,k,t)) - (alpha_m(V(k,t)) + 2*beta_m(V(k,t)) + alpha_h(V(k,t)))*mh(2,3,k,t)) + mh(2,3,k,t);

	mh(1,2,k,t+1) = dt*((alpha_h(V(k,t))*mh(2,2,k,t) + 3*alpha_m(V(k,t))*mh(1,1,k,t) + 2*beta_m(V(k,t))*mh(1,3,k,t)) - (2*alpha_m(V(k,t)) + beta_m(V(k,t)) + beta_h(V(k,t)))*mh(1,2,k,t)) + mh(1,2,k,t);

	mh(2,2,k,t+1) = dt*((beta_h(V(k,t))*mh(1,2,k,t) + 3*alpha_m(V(k,t))*mh(2,1,k,t) + 2*beta_m(V(k,t))*mh(2,3,k,t)) - (2*alpha_m(V(k,t)) + beta_m(V(k,t)) + alpha_h(V(k,t)))*mh(2,2,k,t)) + mh(2,2,k,t);

	mh(1,1,k,t+1) = dt*((beta_m(V(k,t))*mh(1,2,k,t) + alpha_h(V(k,t))*mh(2,1,k,t)) - (3*alpha_m(V(k,t)) + beta_h(V(k,t)))*mh(1,1,k,t) ) + mh(1,1,k,t);

	mh(2,1,k,t+1) = dt*((beta_m(V(k,t))*mh(2,2,k,t) + beta_h(V(k,t))*mh(1,1,k,t)) - (3*alpha_m(V(k,t)) + alpha_h(V(k,t)))*mh(2,1,k,t) ) + mh(2,1,k,t);


	n(1,k,t+1) = dt*(beta_n(V(k,t))*n(2,k,t) - 4*alpha_n(V(k,t))*n(1,k,t)) + n(1,k,t);

	n(2,k,t+1) = dt*((4*alpha_n(V(k,t))*n(1,k,t) + 2*beta_n(V(k,t))*n(3,k,t)) - ((3*alpha_n(V(k,t)) + beta_n(V(k,t)))*n(2,k,t))) + n(2,k,t);

	n(3,k,t+1) = dt*((3*alpha_n(V(k,t))*n(2,k,t) + 3*beta_n(V(k,t))*n(4,k,t)) - ((2*alpha_n(V(k,t)) + 2*beta_n(V(k,t)))*n(3,k,t))) + n(3,k,t);

	n(4,k,t+1) = dt*((2*alpha_n(V(k,t))*n(3,k,t) + 4*beta_n(V(k,t))*n(5,k,t)) - ((alpha_n(V(k,t)) + 3*beta_n(V(k,t)))*n(4,k,t))) + n(4,k,t);

	n(5,k,t+1) = dt*(alpha_n(V(k,t))*n(4,k,t) - 4*beta_n(V(k,t))*n(5,k,t)) + n(5,k,t);

	G_na = g_Na * mh(1,4,k,t);
	G_k  = g_K * n(5,k,t);
	G_l  = g_L;
	
	if(k == 1)
		V(1,t+1) = (G_k*V_K + G_l*V_L + G_na*V_Na + (C*V(1,t))/dt + (R*V(2,t)*a1*dx^2)/2 + (I0*pi*a1*dx*t^2*exp(-10*t))/2)/((R*a1*dx^2)/2 + G_k + G_l + G_na + C/dt);
		
	elseif(k ==2)
		V(2,t+1) = ((R*a1*(V(1,t) + V(3,t))*dx^2)/2 + G_k*V_K + G_l*V_L + G_na*V_Na + (C*V(2,t))/dt)/(R*a1*dx^2 + G_k + G_l + G_na + C/dt);
	
	elseif(k ==3)
		V(3,t+1) = (V(2,t)*a1^2 + V(4,t)*a2^2 + V(5,t)*a3^2)/(a1^2 + a2^2 + a3^2);
	
	elseif(k ==4)
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
%%


