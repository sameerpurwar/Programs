function [D,edges] =  Categorize(data,n)
    D = zeros(size(data));
    edges = linspace(0,180,n);
    for  i = 1:n-1
        D(data > edges(i) & data <= edges(i+1)) = edges(i+1);
    end 
end