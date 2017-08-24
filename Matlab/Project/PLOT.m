figure
P = zeros(21,21,length(datacell));
for i = 1:length(datacell)
    shape = datacell{1,i};
    [~,~,Q] = Check(Rtable,shape,1);
    P(:,:,i) = Q; 
    disp(i)
end
for i = 1:length(datacell)
    subplot(6,4,i)
    I = imadjust((P(:,:,i)./sum(sum(P(:,:,i)))));
    imshow(I)
   
end