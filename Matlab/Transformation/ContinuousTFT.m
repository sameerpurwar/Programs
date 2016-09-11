syms w t
f = (heaviside(t+1)-heaviside(t-1));

%ezplot(f,[-20 20]);
%ylim([-1 Inf])
%%
F = fourier(f,w);

ezplot(abs(F));