Wcore = [40,40,40,40,40];
Wcopper = [10 20 60 120 148]./2;
X = (Wcore./Wcopper).^(1/2);
x = [0.25 0.5 0.75 1 1.1]; 
A = (1000.*x)*.8;
E = (A./(A + Wcopper + Wcore))*100;
%%
[x,y] = meshgrid(-37.5:.4:37.5, -25:.4:25);
u = x.^2 + y.^2;
surf(x,y,u);
xlabel('X');
ylabel('Y');
zlabel('Z');
%%
syms x
F = ((79.8/2000)*x)^2 + ((60.18*x + 1800)/2000)^2 - 1;
ezplot(F,[-30 10]);
grid on;
%%
M = [0.02 3.2 7.1 10.25 14.5 22 26 31.7 33.2 33.5 30 28 22 18 28 22 18 14 10 7 4 2 1]./0.4;
N = uint8(M);
F = [18 25 85 150 200 300 500 700 900 1000 1200 1500 1700 2000 2500 4000  5000 7000 10000 150000 25000 50000 100000]./25;
F = uint8(F);
P = int16([88 85 76.5 65 59.6 47 28 14 6.6 2.05 -4.13 -14.13 -17.63 -25.73 -32.40]./2);
%%
syms t w
F = exp(-(t^2));
X = fourier(F,w);
Y = X * -1i*sign(w);
Z = simplify(ifourier(Y,t));
%%
syms s 
X1 = 1 + 0.765*s + s^2;
X2 = 1 + 1.848*s + s^2;
Y = X1 * X2;
%%
x = [1:1000];
y = log(x);
plot(x,y);
%%
I1 = [1.24 1.20 1.10 1.00 0.90 0.70 0.60 0.50 0.30];
Rpm1 = [1210 1218 1240 1286 1316 1400 1490 1594 2054];
plot(I1,Rpm1);
hold on;
I2 = [1.20 1.10 1.00 0.90 0.70 0.60 0.50 0.40 0.30];
Rpm2 = [1118 1138 1162 1192 1226 1350 1432 1600 1914];
plot(I2,Rpm2)
%%
Rpm1 = [1448 1398 1248 1134 1006 948 825 701 642];
Rpm2 = [1502 1444 1318 1186 1054 988 864 725 668];
V = [230 220 200 180 160 150 130 110 100];
plot(V,Rpm1);
hold on;
plot(V,Rpm2);