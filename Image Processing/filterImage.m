image = B; 
%image = im2double(image);
X = zeros(size(image));
Y = zeros(size(image));

n = (-10:10);
b = cos(-n.^(2)) + sin(-(2).^n);
a = 1;

for k = 1:1
    for i = 1:size(X,2)
        X(:,i,k) = filter(b,a,image(:,i,k));
    end
end

for k = 2:2
    for i = 1:size(X,1)
        Y(i,:,k) = filter(b,a,image(i,:,k));
    end
end


figure 
subplot(1,2,1);
imshow(X);

subplot(1,2,2);
imshow(Y);

final = X+Y;
figure
imshow(final);

imwrite(final,'filtersam.jpg');
