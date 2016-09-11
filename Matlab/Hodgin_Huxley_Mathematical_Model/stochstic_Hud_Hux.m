%% This is the modelling of neuron (stochastic kinetic model)

iter = input('enter the iteration(time in milli second): ');
I    = input('enter the impulse current in nanoAmpere: ');

%% defining function
alpha_n = @(V) 0.01*(10 - V)/(exp((10-V)/10) - 1);
alpha_m = @(V) 0.1*(25 - V)/(exp((25-V)/10) - 1);
alpha_h = @(V) 0.07*exp(-V/20);

beta_n = @(V) 0.125*exp(-V/80);
beta_m = @(V) 4*exp(-V/18);
beta_h = @(V) 1/(exp((30-V)/10) + 1);

%%  initializing variables

V = zeros(iter,1);

g_Na = 120;
g_K  = 36;
g_L  = 0.3;

V_Na = 115;
V_K  = -12;
V_L  = 10.6;

C = 1;

dt = 0.01;

m3h0 = zeros(iter);

n4 = zeros(iter);

%% initializing resting voltage

V(1) = 0;


m3h0(1) = 0.5;

n4(1) = 0.2;
%% looping backward euler

for t = 1:iter

	G_Na = g_Na * m3h0(t);
	G_K  = g_K * n4(t);
	G_L  = g_L;
	
	V(t+1) = V(t) + (I - (G_Na*(V(t) - V_Na) + G_K*(V(t) - V_K) + G_L*(V(t) - V_L)))*(dt/C);
	m3h0(t+1) = rand(1);
	n4(t+1) = rand(1);
	
	
end
%% 
plot(V);
grid on;