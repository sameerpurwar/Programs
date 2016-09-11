c =0;
for i = 1:100
   W = Neuron(0.36);
   X = [-1 -1 -1 -1;0 0 1 1;0 1 0 1];
   Y = (W' * X > 0);
   T = [0 1 1 0];
   if(isequal(T,Y))
       c = c+ 1;
   end
end
disp(c);
c = 0;
