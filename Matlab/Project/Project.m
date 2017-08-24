function [properties,datacell,link,grad,Canny,edges] = Project(Image,num)
%I1 = imread('shapes.png');
I1 = imread(Image);
%num= 1;
if length(size(I1)) == 3
    I2 = rgb2gray(I1);
else
    I2 = double(I1);
end

Canny = edge(I2,'Canny');
[~,grad] = imgradient(I2);
grad = grad .* Canny; 

grad(Canny ~= 0 & grad <= 0) = 180 + grad(Canny ~= 0 & grad <= 0);
%grad(Canny ~= 0 & grad <= 0) = -grad(Canny ~= 0 & grad <= 0);
grad(Canny ~= 0 & grad == 0) = 180;


[~, link,~] = edgelink(Canny);
SE = strel('rectangle', [2,2]);
link = imdilate(link,SE);



shape = size(link);
maximum = max(max(link));
datacell = {1,maximum};

c = 1;
for i = 1:maximum
    index = find(link == i);
    if length(index) <=  200
        link(index) = 0;
    else
        link(index) = c;
        c = c + 1;
    end        
end
properties = zeros();
for i = 1:c-1
    index = find(link == i);    
    dataxy = zeros(length(index),8);
    
    

% for the x-y cordinates
    for j = 1:length(index)
        dataxy(j,1) = ceil(index(j)/shape(1));
        dataxy(j,2) = shape(1) - rem(index(j),shape(1)) + 1;
    end
    
% for the properties
   properties(i,1) = mean(dataxy(:,1));
   properties(i,2) = mean(dataxy(:,2)); 
   dataxy(:,3) = dataxy(:,1) - properties(i,1);           % x
   dataxy(:,4) = dataxy(:,2) - properties(i,2);           % y   
   dataxy(:,5) =  sqrt(dataxy(:,3).^2 + dataxy(:,4).^2);  % r
   dataxy(:,6) = atan2d(dataxy(:,4),dataxy(:,3));         % alpha
   dataxy(:,7) = grad(index);                              % phi
   %dataxy(:,8) = ceil(dataxy(:,7));                      % useful making R table    
   [dataxy(:,8),edges] = Categorize(dataxy(:,7),91);
   if num == 1
        datacell{1,i} = dataxy(:,[5,6,8]); % for template (R-Table)
   elseif num == 2
        datacell{1,i} = dataxy(:,[3,4,8]); % for checking
   elseif num == 3
       datacell{1,i} = dataxy;
   end
   
end
end
