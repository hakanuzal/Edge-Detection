function EdgeIm = EdgeDetection(no,C,Sx,Sy)
%% Edge Detection Algoritmalarý
[M, N] = size(C);
threshold = [1.4 4.2 5.8];
I = zeros(M,N);
for i=1:M-2
    for j=1:N-2
        % x-yönündeki ..... mask
Gx = sum(sum(Sx.*C(i:i+2,j:j+2)));
% ((2*C(i+2,j+1) + C(i+2,j) + C(i+2,j+2)) - ...
%     (2*C(i,j+1) + C(i,j) + C(i,j+2)));
        % y-yönündeki ..... mask
Gy = sum(sum(Sy.*C(i:i+2,j:j+2)));
% ((2*C(i+1,j+2) + C(i,j+2) + C(i+2,j+2)) - ...
%     (2*C(i+1,j) + C(i,j) + C(i+2,j)));
% Görüntü gradyentinin þiddetini hesaplama
I(i+1,j+1)= sqrt(Gx.^2+Gy.^2);
     end
end
%// Threshold image
EdgeIm = I > threshold(no)*0.07; 
