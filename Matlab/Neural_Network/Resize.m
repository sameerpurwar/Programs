%% Enlargement
function Y = Resize(X,Sx,Sy)
    area = size(X);
    m = (area(1)-1)*Sy + 1;
    n = (area(2)-1)*Sx + 1;
    Y = zeros(m,n);
    A1 = (Sy.*(0:area(1)-1))+1;
    A2 = (Sx.*(0:area(2)-1))+1;
    Y(A1,A2) = X;
    Y = uint8(Y);
end