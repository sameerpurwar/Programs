function f = convolution(g,h)
    lg = length(g);
    lh = length(h);
    revh = reverse(h);
    gg = [zeros(1,lh) g];
    hh = [revh zeros(1,lg)];
    f = zeros(1,(lg+lh-1));
    for i = 1:(lg+lh-1)
        f(i) = sum(gg.*Rightshift(hh,i));
    end
end

function rf = Rightshift(f,n)
    rf = [zeros(1,n) f(1:(end-n))];
end 

function rev = reverse(f)
    rev = f(end:-1:1);
end