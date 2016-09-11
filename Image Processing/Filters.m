N = input('Enter the vakue of range-->');
a = [1 2];
b = [2 2];
x = [1 zeros(1,N)];
y = filter(b,a,x);
stem((0:N),y);
%% Example 

a = [11 2 3];
b = [-1 -1 -1];
x = [1 3 4 5 6];
y = filter(b,a,x);
stem((0:length(x)-1),y);

%% conv & filter
X = [1 -1 3 zeros(1,8)];
Y1 = convolution(y,X);
Y2 = filter(b,a,X);