function [m,Y] = Bspline4(X,t)
    XX = [0 X 0 0];
    l = length(X)-1;
    m = linspace(0,l,(t+1)*l + 1);
    i = floor(m);
    Bk = @(x)(((heaviside(x) - heaviside(x-1)).*((x.^3)/6)) + ((heaviside(x-1) - heaviside(x-2)).*((-3*x.^3 + 12*x.^2 - 12*x + 4)/6)))...
         + ((heaviside(x-2) - heaviside(x-3)).*((3*x.^3 - 24*x.^2 + 60*x - 44)/6)) + ((heaviside(x-3) - heaviside(x-4)).*(((4-x).^3)/6));
    Bk = @(x)Bk(x+2);
    Y  = Bk(m-i+1).*XX(i+1) + Bk(m-i).*XX(i+2) + Bk(m-i-1).*XX(i+3) + Bk(m-i-2).*XX(i+4);
end


