%load CIFAR10by 16
%%
testdata = ValidN;
%%
data = DataN;
%%
check = testdata(:,1) + 1;
V = randn(501,80)/290;
W = randn(81,10)/45;
%%
logic = zeros(10000,1);

logic(1) = 0;

preVj = 0;
preWj = 0;
alpha = 1;

%%
r = input('Enter the value of r ');
for m = 1:400
    for n = 1:40000    
        tk = zeros(10,1);
        X = [-1;data(n,2:end)'];
        t = data(n,1) + 1;
        tk(t) = 1; 

        hj = V' * X;
        aj = [-1;inverse(hj)];
        bk = W' * aj;
        yk = inverse(bk);

        Wj = (yk - tk).*(1./(1 + (yk.*yk)));
        deltaWj = r*(aj * Wj') + alpha*preWj;

        Vj = (W * Wj).*(1./(1 + (aj.*aj)));
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
        A = inverse(A);
        A = [-1 A];
        A = A * W;
        A = inverse(A);
        [~,a(k)] = max(A);
    end
    logic(m) = sum(check == a)/10000;
   
    disp(logic(m)*100);
    
end 
%%
clear a A aj alpha bk check data deltaVj deltaWj hj k logic m  n Vj W Wj X yk 
clear V tk testdata t r preWj preW preVj preV Vjj
