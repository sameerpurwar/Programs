syms wo T t n
f = heaviside(t+1)-heaviside(t-1);
T = 100;
wo = 2*pi/T;
Dn = int(f*exp(-1j*wo*n*t),t,-T/2,T/2)*(1/T);
Dn = simplify(Dn);
%% move on
n11 = (-1000:-1)/wo;
n13 = (1:1000)/wo;
n1 = [n11 n13];
FT = subs(Dn,n,n1)*T;
d0 = limit(Dn,n,0)*T;
plot(n1,FT);
hold on;
plot(0,d0);

%% reconstruct
rfun = sum(array.*exp(1j*wo*n1*t))+ limit(Dn,n,0);
ezplot(rfun,[-T T]);
%%
syms w t
f = (heaviside(t+1)-heaviside(t-1));

%ezplot(f,[-20 20]);
%ylim([-1 Inf])

F = fourier(f,w);

ezplot(F);
