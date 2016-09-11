%% for input case one(clockwise)
p = 0:20:160;
V1_c = [0.0191 1.80 3.518 5.27 7.03 8.70 10.45 12.17 13.69];
V1_ac = [-0.0109 1.794 3.42 5.24 7.03 8.71 10.42 12.12 13.70];
%% for output (clockwise & anticlockwise)
V2_c = [-0.63 1.15 2.85 4.61 6.35 8.07 9.78 11.50 13.17];
V2_ac = [0 2.34 4.08 5.83 7.60 9.23 10.97 12.56 13.25];
%%
V3_c = [.0128 1.78 3.45 5.26 6.9 8.67 10.32 12.03 12.18 ];
V3_ac = [0.0125 1.778 3.44 5.27 6.87 8.63 10.31 12.05 12.182];
%%
figure

subplot(2,3,1)
plot(V1_c,p)
grid on
hold on
scatter(V1_c,p)
xlabel('input pot clock')
ylabel('angular position')

subplot(2,3,2)
plot(V1_ac,p)
grid on
hold on
scatter(V1_ac,p)
xlabel('input pot anti-clock')
ylabel('angular position')

subplot(2,3,3)
plot(V2_c,p)
grid on
hold on
scatter(V2_c,p)
xlabel('output pot clock')
ylabel('angular position')

subplot(2,3,4)
plot(V2_ac,p)
grid on
hold on
scatter(V2_ac,p)
xlabel('output pot anti-clock')
ylabel('angular position')

subplot(2,3,5)
plot(V3_c,p)
grid on
hold on
scatter(V3_c,p)
xlabel('error voltage clock')
ylabel('error angular position')

subplot(2,3,6)
plot(V3_ac,p)
grid on
hold on
scatter(V3_ac,p)
xlabel('error voltage anti-clock')
ylabel('error angular position')
%%

m1_c = 11.64;
m1_ac = 11.62;

m2_c = 11.59;
m2_ac = 11.81;

m3_c = 12.3;
m3_ac = 12.3;