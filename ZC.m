function edges = ZC(image)
% arguments initals
sigma = 3;
k=4;
% Notice that some care must be exercised with sigma. If sigma is 
% too small, then only one element of the array will have a nonzero 
% value. If sigma is large, then k must be large, too; otherwise, 
% we are ignoring contributions from pixels that should contribute
% with substantial weight. I'm using 3sigma as gassian kernel size
% because 3sigma is almost a full norm dist cover 99.7%
siz = k*sigma;
if mod(siz,2) == 0 % make it odd
    siz = siz+1;
end
% calculate the gaussian mask
gaussian = Gaussian_mask_pyramid(siz,sigma);
% meshgrid
[x,y] = meshgrid(-(siz-1)/2:(siz-1)/2);
% compute laplace of gaussian by def
LoG = gaussian.*((x.^2+y.^2)/sigma^4-2/sigma^2);
% make sure that LoG sum to 0
LoG = LoG - sum(LoG(:))/siz^2;
% read image
img = image;
if length(size(img)) == 3
    img = rgb2gray(img);
end
% myConv instead of conv2 convolution function
img_filtered = myConv(img, LoG);

% find the zero-crossings according to the definition of partial derivative
% construct logigal array with same size image
edges = false(size(img_filtered)); 

% set threshold empirically, improve result a little bit
img_blur = myConv(img,gaussian);
threshold = 0.04*std2(img_blur)/2;

for x = 2+(siz-1)/2:size(img_filtered,1)-(siz-1)/2-1
    for y=2+(siz-1)/2:size(img_filtered,2)-(siz-1)/2-1
        if sign(img_filtered(x,y))*sign(img_filtered(x,y+1))<0 ||...
                sign(img_filtered(x,y))*sign(img_filtered(x+1,y))<0
            if std2(img_blur(x-1:x+1,y-1:y+1)) > threshold
                % those low varience edge are noises               
                edges(x,y)=1;
            end
        end
    end
end
edges = im2double(edges);
%{
there's another technique below from 
http://www.coe.utah.edu/~cs4640/slides/Lecture8.pdf
seems work worse
1. Look at your four neighbors, left, right, up and down
2. If they all have the same sign as you, then you are
not a zero crossing
3. Else, if you have the smallest absolute value
compared to your neighbors with opposite sign,
then you are a zero crossing
%}
% figure
% imshow(edges)
% imwrite(edges,strcat(filename,'.bmp'));
end