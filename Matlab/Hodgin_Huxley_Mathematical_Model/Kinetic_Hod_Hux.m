%% This is the modelling of neuron (deterministic kinetic model)

iter = input('enter the iteration(time in milli second): ');
k = 6;
I    = [-3 0 1 6 8 12];

%% defining function
alpha_n = @(V) 0.01*(10 - V)/(exp((10-V)/10) - 1);
alpha_m = @(V) 0.1*(25 - V)/(exp((25-V)/10) - 1);
alpha_h = @(V) 0.07*exp(-V/20);

beta_n = @(V) 0.125*exp(-V/80);
beta_m = @(V) 4*exp(-V/18);
beta_h = @(V) 1/(exp((30-V)/10) + 1);

%%  initializing variables

V = zeros(iter,k);

g_Na = 120;
g_K  = 36;
g_L  = 0.3;

V_Na = 115;
V_K  = -12;
V_L  = 10.6;

C = 1;

dt = 0.01;

m0h0 = zeros(iter,1);
m1h0 = zeros(iter,1);
m2h0 = zeros(iter,1);
m3h0 = zeros(iter,1);
m0h1 = zeros(iter,1);
m1h1 = zeros(iter,1);
m2h1 = zeros(iter,1);
m3h1 = zeros(iter,1);

n0 = zeros(iter,1);
n1 = zeros(iter,1);
n2 = zeros(iter,1);
n3 = zeros(iter,1);
n4 = zeros(iter,1);

%% initializing resting voltage

V(1,:) = -10;

m0h0(1) = 0;
m1h0(1) = 0;
m2h0(1) = 0.5;
m3h0(1) = 0.2;
m0h1(1) = 0;
m1h1(1) = 0.3;
m2h1(1) = 0.7;
m3h1(1) = 1;

n0(1) = 0.1;
n1(1) = 0;
n2(1) = 0.7;
n3(1) = 0.2;
n4(1) = 0.5;
%% looping backward euler

for x = 1:k

	for t = 1:iter

        G_Na = g_Na * m3h0(t);
		G_K  = g_K * n4(t);
		G_L  = g_L;
        
        V(t+1,x) = V(t,x) + (I(x) - (G_Na*(V(t,x) - V_Na) + G_K*(V(t,x) - V_K) + G_L*(V(t,x) - V_L)))*(dt/C);
        
        m3h1(t+1) = dt*((beta_h(V(t,x))*m3h0(t) + alpha_m(V(t,x))*m2h1(t)) - 3*beta_m(V(t,x))*m3h1(t) - alpha_h(V(t,x))*m3h1(t)) + m3h1(t);

		m2h0(t+1) = dt*((alpha_h(V(t,x))*m2h1(t) + 3*beta_m(V(t,x))*m3h0(t) + 2*alpha_m(V(t,x))*m1h0(t)) - (alpha_m(V(t,x)) + 2*beta_m(V(t,x)) + beta_h(V(t,x)))*m2h0(t)) + m2h0(t);

		m2h1(t+1) = dt*((beta_h(V(t,x))*m2h0(t) + 3*beta_m(V(t,x))*m3h1(t) + 2*alpha_m(V(t,x))*m1h1(t)) - (alpha_m(V(t,x)) + 2*beta_m(V(t,x)) + alpha_h(V(t,x)))*m2h1(t)) + m2h1(t);

		m3h0(t+1) = dt*( alpha_m(V(t,x))*m2h0(t)	+ alpha_h(V(t,x))*m3h1(t) - 3*beta_m(V(t,x))*m3h0(t) - beta_h(V(t,x))*m3h0(t)) + m3h0(t);
        
		m1h0(t+1) = dt*((alpha_h(V(t,x))*m1h1(t) + 3*alpha_m(V(t,x))*m0h0(t) + 2*beta_m(V(t,x))*m2h0(t)) - (2*alpha_m(V(t,x)) + beta_m(V(t,x)) + beta_h(V(t,x)))*m1h0(t)) + m1h0(t);

		m1h1(t+1) = dt*((beta_h(V(t,x))*m1h0(t) + 3*alpha_m(V(t,x))*m0h1(t) + 2*beta_m(V(t,x))*m2h1(t)) - (2*alpha_m(V(t,x)) + beta_m(V(t,x)) + alpha_h(V(t,x)))*m1h1(t)) + m1h1(t);

		m0h0(t+1) = dt*((beta_m(V(t,x))*m1h0(t) + alpha_h(V(t,x))*m0h1(t)) - (3*alpha_m(V(t,x)) + beta_h(V(t,x)))*m0h0(t) ) + m0h0(t);

		m0h1(t+1) = dt*((beta_m(V(t,x))*m1h1(t) + beta_h(V(t,x))*m0h0(t)) - (3*alpha_m(V(t,x)) + alpha_h(V(t,x)))*m0h1(t) ) + m0h1(t);


		n0(t+1) = dt*(beta_n(V(t,x))*n1(t) - 4*alpha_n(V(t,x))*n0(t)) + n0(t);

		n1(t+1) = dt*((4*alpha_n(V(t,x))*n0(t) + 2*beta_n(V(t,x))*n2(t)) - ((3*alpha_n(V(t,x)) + beta_n(V(t,x)))*n1(t))) + n1(t);

		n2(t+1) = dt*((3*alpha_n(V(t,x))*n1(t) + 3*beta_n(V(t,x))*n3(t)) - ((2*alpha_n(V(t,x)) + 2*beta_n(V(t,x)))*n2(t))) + n2(t);

		n3(t+1) = dt*((2*alpha_n(V(t,x))*n2(t) + 4*beta_n(V(t,x))*n4(t)) - ((alpha_n(V(t,x)) + 3*beta_n(V(t,x)))*n3(t))) + n3(t);

		n4(t+1) = dt*(alpha_n(V(t,x))*n3(t) - 4*beta_n(V(t,x))*n4(t)) + n4(t);

		
		

	end

	subplot(2,3,x)
	plot(V(:,x))
	grid on
	X = sprintf('at %dnA ',I(x));
	title(X)
	ylabel('V');
	xlabel('time');

end
