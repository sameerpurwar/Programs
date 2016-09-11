%% open loop transfer function

num1 = [3380.148];
den1 = [0.001 0.1 -2.177 -217.72];
T1 = tf(num1,den1);
rlocus(T1);


%%
n1 = [0.1 6];
T3 = tf(num1.*n1 , den1);
rlocus(T3);
%%
n2 = [0.2 6 10];
T4 = tf(num1.*n2 , [den1,0]);
rlocus(T4);
%%
subplot(2,2,1)
rlocus(T1);
title('simple')
subplot(2,2,2)
rlocus(T3);
title('pd control root locus')
subplot(2,2,3)
rlocus(T4);
title('pid control root locus')

%%
s = tf('s');
G = 3380.148/(0.001*s^3 + 0.1* s^2 + -2.177*s - 217.72);
C = 4 + 0.2*s;
T = feedback(G*C,1);
%%
figure
subplot(3,1,1)
plot(sinepd);
subplot(3,1,2)
plot(squarepd);
subplot(3,1,3)
%%
plot(steppd);
%%
figure
subplot(3,1,1)
plot(sinepid);
subplot(3,1,2)
plot(squarepid);
subplot(3,1,3)
plot(steppid);
%%
R =  - 2/s;
%%
s = tf('s');
G = 1488/(s^2 - 30.5^2);
C = 11 + 0.1*s + 6/s;