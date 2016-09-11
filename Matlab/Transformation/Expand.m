function Y2 =  Expand(X,n,m)
    X = rgb2gray(X);
    X = double(X)/255;
    l = size(X);
    Y1 = zeros(l(1),l(2)+((l(2)-1)*(m-1)));
    for i = 1:l(1)
       [~,Y1(i,:)] = Bspline4(X(i,:),m-1);
    end
    Y1 = Y1';
    l = size(Y1);
    Y2 = zeros(l(1),l(2)+((l(2)-1)*(n-1)));
    for i = 1:l(1)
       [~,Y2(i,:)] = Bspline4(Y1(i,:),n-1);
    end
    Y2 = Y2';
end
