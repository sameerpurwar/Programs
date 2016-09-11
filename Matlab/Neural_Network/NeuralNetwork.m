r = input('Enter the learning rate');
V = randn(785,8);
W = randn(9,10);
tk = zeros(10,1);

    for n = 1:1000
        random = randi(5000);
        tk = zeros(10,1);
        X = ([-1;train(random,2:end)'])./255;
        t = train(random,1) + 1;
        tk(t) = 1; 


        hj = V' * X;% 8x1
        aj = [-1;sigmoid(hj)];% 9x1
        bk = W' * aj;% 10x1
        yk = sigmoid(bk);% 10x1

        Wj = (yk - tk).*(yk.*(1 - yk));% 10x1
        deltaWj = r*(aj * Wj');% 9x10

        Vj = (W * Wj).*(aj.*(1 - aj));
        Vj = Vj(2:end);
        deltaVj = r*(X * Vj');

        W = W - deltaWj;
        V = V - deltaVj;
    end


