    function W =  Neuron2(N)
    
    %load('W.mat','W'); % remember the syntax
    W = randi(1000,3,1)  - 500;
    XX = [-1 -1 -1 -1;0 0 1 1;0 1 0 1];
    T = [1 1 1 0];
        for k = 1:size(XX,2)
        i = 1;
            while(i <= 2000)
            Y = sum(XX(:,k)' * W);
            if (Y > 0)
                Y = 1;
            else
                Y = 0;
            end
            dW = N*((Y - T(k))*XX(:,k));
            W = W - dW;
            i = i + 1;
            end 
        
        end
        %disp(W'* XX > 0);
    end
