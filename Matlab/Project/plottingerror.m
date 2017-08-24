Y = zeros(1);
for i = 1:length(YY)
    for j = 1:length(YY{i})
        Y(end + 1) = YY{i}(j);
    end
end

X = zeros(1);
for i = 1:length(XX)
    for j = 1:length(XX{i})
        X(end + 1) = XX{i}(j);
    end
end
scatter(X,Y)