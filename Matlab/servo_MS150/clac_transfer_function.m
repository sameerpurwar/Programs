%%
figure
subplot(2,3,1);
plot(data1(:,1));
subplot(2,3,2);
plot(data2(:,1))
subplot(2,3,3);
plot(data3(:,1))
subplot(2,3,4);
plot(data4(:,1))
subplot(2,3,5);
plot(data5(:,1))
%%
Y1 = data1;
Y2 = data2;
Y3 = data3;
Y4 = data4;
Y5 = data5;

Ts = 0.001;

idata1 = iddata(Y1,U1,Ts);
idata2 = iddata(Y2,U2,Ts);
idata3 = iddata(Y3,U3,Ts);
idata4 = iddata(Y4,U4,Ts);
idata5 = iddata(Y5,U5,Ts);
%%
Est1 = tfest(idata1,2,0);
Est2 = tfest(idata2,2,0);
Est3 = tfest(idata3,2,0);
Est4 = tfest(idata4,2,0);
Est5 = tfest(idata5,2,0);
%%
S1 = stepinfo(Y1);
S2 = stepinfo(Y2);
S3 = stepinfo(Y3);
S4 = stepinfo(Y4);
S5 = stepinfo(Y5);
%%
T1 = tf(Est1.num,Est1.den);
T2 = tf(Est2.num,Est2.den);
T3 = tf(Est3.num,Est3.den);
T4 = tf(Est4.num,Est4.den);
T5 = tf(Est5.num,Est5.den);

%%
figure
subplot(2,3,1)
step(T1)
subplot(2,3,2)
step(T2)
subplot(2,3,3)
step(T3)
subplot(2,3,4)
step(T4)
subplot(2,3,5)
step(T5)
%%
Eta(1) = Est1.den(2)/(2*Est1.den(3)^(0.5));
Eta(2) = Est2.den(2)/(2*Est2.den(3)^(0.5));
Eta(3) = Est3.den(2)/(2*Est3.den(3)^(0.5));
Eta(4) = Est4.den(2)/(2*Est4.den(3)^(0.5));
Eta(5) = Est5.den(2)/(2*Est5.den(3)^(0.5));
%%
w1 = damp(T1);
w2 = damp(T2);
w3 = damp(T3);
w4 = damp(T4);
w5 = damp(T5);
