%% This is the modelling of neuron (not the kinetic model)

iter = input('enter the iteration(time in milli second): ');
k = 6;
I = [10 0 -6 3 2 1];
%% defining kinetic rates

alpha_n = @(V) 0.01*(10 - V)/(exp((10-V)/10) - 1);
alpha_m = @(V) 0.1*(25 - V)/(exp((25-V)/10) - 1);
alpha_h = @(V) 0.07*exp(-V/20);

beta_n = @(V) 0.125*exp(-V/80);
beta_m = @(V) 4*exp(-V/18);
beta_h = @(V) 1/(exp((30-V)/10) + 1);

%% initializing constants

g_Na = 120;
g_K  = 36;
g_L  = 0.3;

V_Na = 115;
V_K  = -12;
V_L  = 10.6;

C = 1;

n = zeros(iter);
m = zeros(iter);
h = zeros(iter);
V = zeros(iter,k);

dt = 0.01;
%% resting values of a neuron
V(1,:) = -40;

m(1) = 1;
n(1) = 1;
h(1) = 1;
%%
figure
for x = 1:k

	for t = 1:iter
		G_Na = g_Na*h(t)*m(t)^3;
		G_K  = g_K*n(t)^4;
		G_L  = g_L;

		V(t+1,x) = V(t,x) + (I(x) - (G_Na*(V(t,x) - V_Na) + G_K*(V(t,x) - V_K) + G_L*(V(t,x) - V_L)))*(dt/C);

		n(t+1) = n(t) + dt*( (alpha_n(V(t,x))*(1-n(t))) - (beta_n(V(t,x))* n(t)) );
		m(t+1) = m(t) + dt*( (alpha_m(V(t,x))*(1-m(t))) - (beta_m(V(t,x))* m(t)) );
		h(t+1) = h(t) + dt*( (alpha_h(V(t,x))*(1-h(t))) - (beta_h(V(t,x))* h(t)) );
	end

	subplot(2,3,x)
	plot(V(:,x))
	grid on
	X = sprintf('at %dnA ',I(x));
	title(X)
	xlabel('V');
	ylabel('time in ms');

	

end



