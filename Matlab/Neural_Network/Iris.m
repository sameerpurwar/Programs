load meas.mat;
load test.mat;
%r = input('Enter the value of r ');
V = randn(5,2);
W = randn(3,3);
check = [1 2 3];
check = repmat(check,10,1);
check = check(:);
logic = zeros(10000,1);
B = randperm(120);
Yk = zeros(10000,3);

r = input('Enter the value of r ');
for m = 1:10000
    for n = B    
        %random = randi(120);
        tk = zeros(3,1);
        X = ([-1;train(n,2:end)']);
        t = train(n,1);
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
    
    a = zeros(30,1);
    for k = 1:30
        A = [-1 test(k,:)];
        A = A * V;
        A = sigmoid(A);
        A = [-1 A];
        A = A * W;
        A = sigmoid(A);
        [~,a(k)] = max(A);
    end
    logic(m) = sum(check == a)/30;
    B = randperm(120);
    Yk(m,:) = yk;
end 


