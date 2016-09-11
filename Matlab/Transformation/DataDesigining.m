for n = 1:50000
    switch trainLabels{n,2}
            case 'airplane'
            trainLabels{n,1} = 0;
            case 'automobile'
            trainLabels{n,1} = 1;
            case 'bird'
            trainLabels{n,1} = 2;
            case 'cat'
            trainLabels{n,1} = 3;
            case 'deer'
            trainLabels{n,1} = 4;
            case 'dog'
            trainLabels{n,1} = 5;
            case 'frog'
            trainLabels{n,1} = 6;
            case 'horse'
            trainLabels{n,1} = 7;
            case 'ship'
            trainLabels{n,1} = 8;
            case 'truck'
            trainLabels{n,1} = 9;
    end
end
%%
numfiles = 50000;
mydata = cell(1, numfiles);

for k = 1:numfiles
  myfilename = sprintf('%d.png', k);
  mydata{k} = importdata(myfilename);
  %disp(k);
end
%%
A = uint8(zeros(50000,3072));
for n = 1:50000
    B = mydata{n};
    A(n,:) = B(:)';
    disp(n);
end