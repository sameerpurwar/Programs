%% Potential along the tree
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

V_1 = zeros(iter,1);
V_2 = zeros(iter,1);
V_3 = zeros(iter,1);
V_4 = zeros(iter,1);
V_5 = zeros(iter,1);

mh = zeros(2,4,5,iter);
n = zeros(5,5,iter);
%%
a1 = 0.0338;
a2 = 0.0138; 
a3 = 0.0138;

dx = 0.5;
R = 0.034;
C = 1;
dt = 0.01;

g_Na = 120;
g_K  = 36;
g_L  = 0.3;

V_Na = 115;
V_K  = -12;
V_L  = 10.6;

%% Solving symbolic function


syms V1 V1p V2 V2p V3 V3p V4 V4p V5 V5p
syms G_na G_k G_l
syms time

F1 = C *(V1 - V1p)/dt + G_na*(V1 - V_Na) + G_k*(V1 - V_K) + G_l*(V1 - V_L) - a1*I*(time^2)*exp(-10*time)/2*pi*dx - a1*(V2 -V1)/2*R*dx^2; 
F2 = C *(V2 - V2p)/dt + G_na*(V2 - V_Na) + G_k*(V2 - V_K) + G_l*(V2 - V_L) - a1*(V3 - 2*V2 + V1)/2*R*dx^2; 
F3 = (a1^2)*(V3 - V2) - (a2^2)*(V4 - V3) - (a3^2)*(V5 - V3);
F4 = C *(V4 - V4p)/dt + G_na*(V4 - V_Na) + G_k*(V4 - V_K) + G_l*(V4 - V_L) - a2*(V4 - V3)/2*R*dx^2;
F5 = C *(V5 - V5p)/dt + G_na*(V5 - V_Na) + G_k*(V5 - V_K) + G_l*(V5 - V_L) - a3*(V5 - V3)/2*R*dx^2;

result = solve(F1 == 0,F2 == 0,F3 ==0,F4 == 0,F5 == 0,[V1,V2,V3,V4,V5]);

%% initializing resting voltage
V_1(1) = -10;
V_2(1) = -5;
V_3(1) = -10;
V_4(1) = -5;
V_5(1) = -10;

for k =  1:5
mh(:,:,k,1) = [0,k/10,0,0.3+k/20 ;
			   0,0,0.5 - k/10,0.2+k/20];

n(:,k,1) = [0.2,0.3,0.2,0.3,0];
end
%% Backward Euler 

for t =1:iter

	mh(1,4,1,t+1) = dt*( alpha_m(V_1(t))*mh(1,3,1,t)	+ alpha_h(V_1(t))*mh(2,4,1,t) - 3*beta_m(V_1(t))*mh(1,4,1,t) - beta_h(V_1(t))*mh(1,4,1,t)) + mh(1,4,1,t);

	mh(2,4,1,t+1) = dt*((beta_h(V_1(t))*mh(1,4,1,t) + alpha_m(V_1(t))*mh(2,3,1,t)) - 3*beta_m(V_1(t))*mh(2,4,1,t) - alpha_h(V_1(t))*mh(2,4,1,t)) + mh(2,4,1,t);

	mh(1,3,1,t+1) = dt*((alpha_h(V_1(t))*mh(2,3,1,t) + 3*beta_m(V_1(t))*mh(1,4,1,t) + 2*alpha_m(V_1(t))*mh(1,2,1,t)) - (alpha_m(V_1(t)) + 2*beta_m(V_1(t)) + beta_h(V_1(t)))*mh(1,3,1,t)) + mh(1,3,1,t);

	mh(2,3,1,t+1) = dt*((beta_h(V_1(t))*mh(1,3,1,t) + 3*beta_m(V_1(t))*mh(2,4,1,t) + 2*alpha_m(V_1(t))*mh(2,2,1,t)) - (alpha_m(V_1(t)) + 2*beta_m(V_1(t)) + alpha_h(V_1(t)))*mh(2,3,1,t)) + mh(2,3,1,t);

	mh(1,2,1,t+1) = dt*((alpha_h(V_1(t))*mh(2,2,1,t) + 3*alpha_m(V_1(t))*mh(1,1,1,t) + 2*beta_m(V_1(t))*mh(1,3,1,t)) - (2*alpha_m(V_1(t)) + beta_m(V_1(t)) + beta_h(V_1(t)))*mh(1,2,1,t)) + mh(1,2,1,t);

	mh(2,2,1,t+1) = dt*((beta_h(V_1(t))*mh(1,2,1,t) + 3*alpha_m(V_1(t))*mh(2,1,1,t) + 2*beta_m(V_1(t))*mh(2,3,1,t)) - (2*alpha_m(V_1(t)) + beta_m(V_1(t)) + alpha_h(V_1(t)))*mh(2,2,1,t)) + mh(2,2,1,t);

	mh(1,1,1,t+1) = dt*((beta_m(V_1(t))*mh(1,2,1,t) + alpha_h(V_1(t))*mh(2,1,1,t)) - (3*alpha_m(V_1(t)) + beta_h(V_1(t)))*mh(1,1,1,t) ) + mh(1,1,1,t);

	mh(2,1,1,t+1) = dt*((beta_m(V_1(t))*mh(2,2,1,t) + beta_h(V_1(t))*mh(1,1,1,t)) - (3*alpha_m(V_1(t)) + alpha_h(V_1(t)))*mh(2,1,1,t) ) + mh(2,1,1,t);


	n(1,1,t+1) = dt*(beta_n(V_1(t))*n(2,1,t) - 4*alpha_n(V_1(t))*n(1,1,t)) + n(1,1,t);

	n(2,1,t+1) = dt*((4*alpha_n(V_1(t))*n(1,1,t) + 2*beta_n(V_1(t))*n(3,1,t)) - ((3*alpha_n(V_1(t)) + beta_n(V_1(t)))*n(2,1,t))) + n(2,1,t);

	n(3,1,t+1) = dt*((3*alpha_n(V_1(t))*n(2,1,t) + 3*beta_n(V_1(t))*n(4,1,t)) - ((2*alpha_n(V_1(t)) + 2*beta_n(V_1(t)))*n(3,1,t))) + n(3,1,t);

	n(4,1,t+1) = dt*((2*alpha_n(V_1(t))*n(3,1,t) + 4*beta_n(V_1(t))*n(5,1,t)) - ((alpha_n(V_1(t)) + 3*beta_n(V_1(t)))*n(4,1,t))) + n(4,1,t);

	n(5,1,t+1) = dt*(alpha_n(V_1(t))*n(4,1,t) - 4*beta_n(V_1(t))*n(5,1,t)) + n(5,1,t);

	G_Na = g_Na * mh(1,4,1,t);
	G_K  = g_K * n(5,1,t);
	G_L  = g_L;
	
	%V_1(t+1) = V_1(t) + (I - (G_Na*(V_1(t) - V_Na) + G_K*(V_1(t) - V_K) + G_L*(V_1(t) - V_L)))*(dt/C);
	V_1(t+1) = subs(result.V1,[V1p V2p V3p V4p V5p G_na G_k G_l time],[V_1(t) V_2(t) V_3(t) V_4(t) V_5(t) G_Na G_K G_L t]);
	V_2(t+1) = subs(result.V2,[V1p V2p V3p V4p V5p G_na G_k G_l time],[V_1(t) V_2(t) V_3(t) V_4(t) V_5(t) G_Na G_K G_L t]);
	V_3(t+1) = subs(result.V3,[V1p V2p V3p V4p V5p G_na G_k G_l time],[V_1(t) V_2(t) V_3(t) V_4(t) V_5(t) G_Na G_K G_L t]);
	V_4(t+1) = subs(result.V4,[V1p V2p V3p V4p V5p G_na G_k G_l time],[V_1(t) V_2(t) V_3(t) V_4(t) V_5(t) G_Na G_K G_L t]);
	V_5(t+1) = subs(result.V5,[V1p V2p V3p V4p V5p G_na G_k G_l time],[V_1(t) V_2(t) V_3(t) V_4(t) V_5(t) G_Na G_K G_L t]);
	disp(t);
end

%%
figure
subplot(2,3,1)
plot(V_1)
grid on

subplot(2,3,2)
plot(V_2)
grid on

subplot(2,3,3)
plot(V_3)
grid on

subplot(2,3,4)
plot(V_4)
grid on

subplot(2,3,5)
plot(V_5)
grid on