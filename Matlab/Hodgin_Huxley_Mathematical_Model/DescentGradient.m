%% This is the modelling of neuron (deterministic kinetic model)

iter = input('enter the iteration(time in milli second): ');
I    = input('enter the impulse current in nanoAmpere: ');
alpha = input('enter the learning rate: ');

%% defining function
alpha_n = @(V) 0.01*(10 - V)/(exp((10-V)/10) - 1);
alpha_m = @(V) 0.1*(25 - V)/(exp((25-V)/10) - 1);
alpha_h = @(V) 0.07*exp(-V/20);

beta_n = @(V) 0.125*exp(-V/80);
beta_m = @(V) 4*exp(-V/18);
beta_h = @(V) 1/(exp((30-V)/10) + 1);

%%  initializing variables

V = zeros(iter,1);
V_target = zeros(iter,1);

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
 
dw = 0;
%% initializing resting voltage

V(1) = -10;

m0h0(1) = 0;
m1h0(1) = 0;
m2h0(1) = 0;
m3h0(1) = 0.3;
m0h1(1) = 0;
m1h1(1) = 0;
m2h1(1) = 0.5;
m3h1(1) = 0.2;

n0(1) = 0.2;
n1(1) = 0.3;
n2(1) = 0.2;
n3(1) = 0.3;
n4(1) = 0;

w1 = 30;
w2 = 5;
w3 = 1.9;


Y1 = zeros(iter,1);
Y2 = zeros(iter,1);
Y3 = zeros(iter,1);
w = [w1 w2 w3];

w_norm = (w - mean(w))/std(w);
%% looping backward euler

for t = 1:iter

	
	m3h0(t+1) = dt*( alpha_m(V(t))*m2h0(t)	+ alpha_h(V(t))*m3h1(t) - 3*beta_m(V(t))*m3h0(t) - beta_h(V(t))*m3h0(t)) + m3h0(t);
	
	m3h1(t+1) = dt*((beta_h(V(t))*m3h0(t) + alpha_m(V(t))*m3h0(t)) - 3*beta_m(V(t))*m3h1(t) - alpha_h(V(t))*m3h1(t)) + m3h1(t);

	m2h0(t+1) = dt*((alpha_h(V(t))*m2h1(t) + 3*beta_m(V(t))*m3h0(t) + 2*alpha_m(V(t))*m1h0(t)) - (alpha_m(V(t)) + 2*beta_m(V(t)) + beta_h(V(t)))*m2h0(t)) + m2h0(t);
	
	m2h1(t+1) = dt*((beta_h(V(t))*m2h0(t) + 3*beta_m(V(t))*m3h1(t) + 2*alpha_m(V(t))*m1h1(t)) - (alpha_m(V(t)) + 2*beta_m(V(t)) + alpha_h(V(t)))*m2h1(t)) + m2h1(t);
	
	m1h0(t+1) = dt*((alpha_h(V(t))*m1h1(t) + 3*alpha_m(V(t))*m0h0(t) + 2*beta_m(V(t))*m2h0(t)) - (2*alpha_m(V(t)) + beta_m(V(t)) + beta_h(V(t)))*m1h0(t)) + m1h0(t);

	m1h1(t+1) = dt*((beta_h(V(t))*m1h0(t) + 3*alpha_m(V(t))*m0h1(t) + 2*beta_m(V(t))*m2h1(t)) - (2*alpha_m(V(t)) + beta_m(V(t)) + alpha_h(V(t)))*m1h1(t)) + m1h1(t);
	
	m0h0(t+1) = dt*((beta_m(V(t))*m1h0(t) + alpha_h(V(t))*m0h1(t)) - (3*alpha_m(V(t)) + beta_h(V(t)))*m0h0(t) ) + m0h0(t);

	m0h1(t+1) = dt*((beta_m(V(t))*m1h1(t) + beta_h(V(t))*m0h0(t)) - (3*alpha_m(V(t)) + alpha_h(V(t)))*m0h1(t) ) + m0h1(t);


	n0(t+1) = dt*(beta_n(V(t))*n1(t) - 4*alpha_n(V(t))*n0(t)) + n0(t);

	n1(t+1) = dt*((4*alpha_n(V(t))*n0(t) + 2*beta_n(V(t))*n2(t)) - ((3*alpha_n(V(t)) + beta_n(V(t)))*n1(t))) + n1(t);
	
	n2(t+1) = dt*((3*alpha_n(V(t))*n1(t) + 3*beta_n(V(t))*n3(t)) - ((2*alpha_n(V(t)) + 2*beta_n(V(t)))*n2(t))) + n2(t);
	
	n3(t+1) = dt*((2*alpha_n(V(t))*n2(t) + 4*beta_n(V(t))*n4(t)) - ((alpha_n(V(t)) + 3*beta_n(V(t)))*n3(t))) + n3(t);

	n4(t+1) = dt*(alpha_n(V(t))*n3(t) - 4*beta_n(V(t))*n4(t)) + n4(t);


	G_Na = w1 * m3h0(t);
	G_K  = w2 * n4(t);
	G_L  = w3;
	
	V(t+1) = V(t) + (I - (G_Na*(V(t) - V_Na) + G_K*(V(t) - V_K) + G_L*(V(t) - V_L)))*(dt/C);

	for k = 1:iter

	G = -(w1*m3h0(k) + w2*n4(k) + w3)/C;

	Y1(k+1) = dt * (G*Y1(k) - m3h0(k)*(V(k) - V_Na)/C) + Y1(k);

	Y2(k+1) = dt * (G*Y2(k) - n4(t)*(V(k) - V_K)/C) + Y2(k);	

	Y3(k+1) = dt * (G*Y3(k) - (V(k) - V_L)/C) + Y3(k);
	
	end
	% updating parameters
	dw = dw - dt*dw/Ta + dt*(V - V_target).*Y1*w1; 
	w_norm = w_norm - alpha*dt.*dw;
end




