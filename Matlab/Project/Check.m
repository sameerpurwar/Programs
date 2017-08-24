function [XX,YY,P] = Check(Rtable,data,num)
    n = 21;
    X = linspace(-100,100,n);
    Y = linspace(-100,100,n);
    S = num;
    P = zeros(n,n,length(S));
    for i =  1:length(data(:,3))
        index = find(Rtable(:,3) == data(i,3));
        %disp(i);
        for s = 1:length(S)
            x = data(i,1) - Rtable(index,1).*cosd(Rtable(index,2))*S(s);
            y = data(i,2) - Rtable(index,1).*sind(Rtable(index,2))*S(s);
            XX{i} = x;
            YY{i} = y;
            
            for  j = 1:length(X)-1
                for  k = 1:length(Y)-1
                ind = (x > X(j) & x <= X(j+1) & y > Y(k) & y <= Y(k+1));
                P(j,k,s) = P(j,k,s) + sum(ind);
                end
            end
        end
    end
end