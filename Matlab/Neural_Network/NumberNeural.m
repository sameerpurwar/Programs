load Final % by 16
%%
check = testdata(:,1) + 1;
V = randn(785,50);
W = randn(51,10);
logic = zeros(7003,1);
Yk = zeros(7003,10);
logic(1) = 0;
intermediate = 0;

preVj = 0;
preWj = 0;
alpha = 1;
B = randperm(35000);

%%
r = input('Enter the value of r ');
for m = 1:10
    for n = B    
        tk = zeros(10,1);
        X = [-1;data(n,2:end)'];
        t = data(n,1) + 1;
        tk(t) = 1; 

        hj = V' * X;
        aj = [-1;sigmoid(hj)];
        bk = W' * aj;
        yk = sigmoid(bk);

        Wj = (yk - tk).*(yk.*(1 - yk));
        deltaWj = r*(aj * Wj') + alpha*preWj;

        Vj = (W * Wj).*(aj.*(1 - aj));
        Vj = Vj(2:end);
        deltaVj = r*(X * Vj') + alpha*preVj;

        W = W - deltaWj ;
        V = V - deltaVj;
        preW = deltaWj;
        preV = deltaVj;
    end
    
    
    
    a = zeros(7003,1);
    for k = 1:7003
        A = [-1,testdata(k,2:end)];
        A = A * V;
        A = sigmoid(A);
        A = [-1 A];
        A = A * W;
        A = sigmoid(A);
        [~,a(k)] = max(A);
    end
    logic(m) = sum(check == a)/7003;
   
    disp(logic(m)*100);
    
end 


