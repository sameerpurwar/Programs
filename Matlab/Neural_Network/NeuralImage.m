load CIFAR10by40 %40
%%
testdata = Valid;
clear Valid
%%
data = Data;
clear Data;
%%
check = testdata(:,1) + 1;
V = randn(3073,200);
W = randn(201,10);
%%
logic = zeros(10000,1);

logic(1) = 0;

preVj = 0;
preWj = 0;
alpha = 1;




%%
r = input('Enter the value of r ');
for m = 1:30
    for n = 1:40000    
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
    disp(m);
    
    
    a = zeros(10000,1);
    for k = 1:10000
        A = [-1,testdata(k,2:end)];
        A = A * V;
        A = sigmoid(A);
        A = [-1 A];
        A = A * W;
        A = sigmoid(A);
        [~,a(k)] = max(A);
    end
    logic(m) = sum(check == a)/10000;
   
    disp(logic(m)*100);
    
end 


