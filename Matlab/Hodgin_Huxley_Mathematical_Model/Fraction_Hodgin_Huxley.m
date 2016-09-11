num = 3000;
%%
c = zeros(num,1);
m = zeros(num,1);
n = zeros(num,1);
hbar = zeros(num,1);
V = zeros(num,1);
%%
alpha_n = @(V) 0.01*(10 - V)/(exp((10-V)/10) - 1);
alpha_m = @(V) 0.1*(25 - V)/(exp((25-V)/10) - 1);
alpha_hbar = @(V) 0.07*exp(-V/20);

beta_n = @(V) 0.125*exp(-V/80);
beta_m = @(V) 4*exp(-V/18);
beta_hbar = @(V) 1/(exp((30-V)/10) + 1);

%%
eta = 1;
C = 1;
h = 0.01;

g_Na = 120;
g_K  = 36;
g_L  = 0.3;

V_Na = 115;
V_K  = -12;
V_L  = 10.6;

c(1) = h^(-eta);
m(1) = 0;
n(1) = 0;
hbar(1) = 1;

I = 0;
V(1) = -40;
%%
for k = 1:num
    c(k+1) = c(k) * (1 - (1 + eta)/k);
end

for k = 1:num
    
    G_Na = g_Na*hbar(k)*m(k)^3;
    G_K  = g_K*n(k)^4;
	G_L  = g_L;
    
    A = (V(k:-1:1,1).*c(2:k+1,1))/c(1);
    %V(t+1,x) = V(t,x) + (I(x) - (G_Na*(V(t,x) - V_Na) + G_K*(V(t,x) - V_K) + G_L*(V(t,x) - V_L)))*(dt/C);
    V(k+1)    =  -(sum(V(k:-1:1,1).*c(2:k+1,1))/c(1))  +  (I - (G_Na*(V(k) - V_Na)) - (G_K*(V(k) - V_K)) - (G_L*(V(k) - V_L)))/(C*c(1));
    
    m(k+1)    =  -sum(m(k:-1:1,1).*c(2:k+1,1))/c(1)    +  ((alpha_m(V(k))*(1-m(k))) - (beta_m(V(k))*m(k)))/c(1);
    n(k+1)    =  -sum(n(k:-1:1,1).*c(2:k+1,1))/c(1)    +  ((alpha_n(V(k))*(1-n(k))) - (beta_n(V(k))*n(k)))/c(1);
    hbar(k+1) =  -sum(hbar(k:-1:1,1).*c(2:k+1,1))/c(1) +  ((alpha_hbar(V(k))*(1-hbar(k))) - (beta_hbar(V(k))*hbar(k)))/c(1);  
end

