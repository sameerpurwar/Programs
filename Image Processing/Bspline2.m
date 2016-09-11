function [m,Y] = Bspline2(X,t)
    XX = [X 0 0 0];
    l = length(X)-1;
    m = linspace(0,l,(t+1)*l + 1);
    i = floor(m);
    Bk = @(x)(1-abs(x));      
    Y  = Bk(m-i).*XX(i+1) + Bk(m-i-1).*XX(i+2);
end


