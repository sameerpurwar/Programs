%data = zeros(1,784,10);

        A = (train(:,1) == 9);
        data = train(A,:);  
        clear A;
