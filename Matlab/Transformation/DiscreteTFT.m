syms n w
f = exp(-n^2);
n1 = (0:20);
X = subs(f,n,n1);
subplot(2,2,3);
stem(n1,X);
%%
Xw = sum(exp(-1j*w*n1).*X);
ezplot(abs(Xw));
ylim([-1 Inf]);
%%
syms t
fun = ifourier(Xw,t);
ezplot(fun);
%% Discrete Fourier Transform
syms n k 
n1 = (0:20);
N = length(n1);
f = (0.8).^n1;
Xk = sum(f.*exp(-1j*(2*pi*k/N)*n1)); 
Xkk = subs(Xk,k,(0:40));
fun = abs(eval(Xkk));
%% DTFT & DFT
syms n w
Ts = 0.1;
n1 = (-100:100);
y = 0.8.^n;
Y = subs(y,n,n1*Ts);
stem(n1,Y);
%% =====
Xw = sum(Y.*exp(-1j*w*n1));
ezplot(abs(Xw),[-2*pi 2*pi]);
%%
n1 = -3:0.1:-1.1;
n2 = -1:0.1:1;
n3 = 1.1:0.1:3;
n = [n1 n2 n3];
f1 = zeros(size(n1));
f2 = ones(size(n2));
f3 = zeros(size(n3));
f = [f1 f2 f3];
stem(n,f);
%%
syms w
dtft = f.*exp(-1j*w*n);
dtft = sum(dtft);
ezplot(dtft);
grid on
