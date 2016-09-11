function W =  Neuron(N)
    %load('W.mat','W'); % remember the syntax
    W = randi(1000,3,1)  - 500;
    XX = [-1 -1 -1 -1;0 0 1 1;0 1 0 1];
    T = [0 1 1 0];
    i = 1;
    while(i <= 2000)
        for k = 1:size(XX,2)
            Y = sum(XX(:,k)' * W);
            if (Y > 0)
                Y = 1;
            else
                Y = 0;
            end
            dW = N*((Y - T(k))*XX(:,k));
            W = W - dW;
        end 
        i = i + 1;
    end
    disp(W'* XX > 0);
end

