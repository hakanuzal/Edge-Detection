clc;close all;clear
[filename,path]=uigetfile({ '*.png; *.jpg; *.bmp; *.tif' }, ... 
                          'Resim Dosyas� Se�ime');
selectedfile = fullfile(path,filename);
if filename == 0
    error('Hata !!! L�tfen Bir Resim Se�iniz.');
end
I1=imread(filename);
% imshow(I1);title(filename);

% G�r�nt� RGB ise Gri Tonlamaya d�n���m yapma
if ndims(I1) == 3
   I1 = rgb2gray(I1);
end
I1 = im2double(I1); %// Convert to double
[M,N] = size(I1);
% Matrislere s�f�rlarla �n yer ay�rma
% Hesaplama i�in double duyarl�kl� g�r�nt� olu�turma
C = double(I1);

Sx= {[0 0 0;0 1 0;0 0 -1], [-1 -1 -1;0 0 0;1 1 1], [-1 -2 -1;0 0 0;1 2 1]};
%    [-1,0,1; -2,0,2; -1,0,1]};
Sy= {[0 0 0;0 0 1;0 -1 0], [-1 0 1;-1 0 1;-1 0 1], [-1 0 1;-2 0 2;-1 0 1]};
%    [1, 2, 1; 0, 0, 0; -1, -2, -1]};
figure
%subplot(3,3,2); 
imshow(I1, []);
title( 'Orijinal G�r�nt�' );
%set(gcf, 'Position', get(0,'Screensize'));
set(gcf, 'name','Kenar Tespiti Yap�lm�� Resimler',...
       'numbertitle','off')
   tit = {'Roberts', ' Prewitt', ' Sobel', 'Canny', 'LoG', 'ZC'};
   hold on
   num = length(tit);
   MSE = zeros(num); RMSE = zeros(num); PSNR = zeros(num);
     EdgeMatrix={};
for i=1:num
    if i<= 3
       EdgeMatrix{i} = EdgeDetection(i,C,Sx{i},Sy{i});
    elseif i==4
       EdgeMatrix{i} = canny_code(C);
    elseif i==5
       EdgeMatrix{i} = LoG(C);
    elseif i==6
       EdgeMatrix{i} = ZC(C);
    end
      figure
      imshow(EdgeMatrix{i}, []);
title([tit{i} ' Gradyent Filtrelenmi� G�r�nt�']);
end

for i=1:num-1
    for j=i+1:num
        SE = (EdgeMatrix{i}-EdgeMatrix{j}).^2;
        MSE(i,j)  = sum(SE(:))/(M*N);
        MSE(j,i)  = MSE(i,j);
        RMSE(i,j) = sqrt(MSE(i,j));
        RMSE(j,i) = RMSE(i,j);
        PSNR(i,j) = 10*log(M*N/MSE(i,j))/log(10);
        PSNR(j,i) = PSNR(i,j);
    end
end

figure
subplot(2,1,1)
plot(RMSE,'linew',3)

legend(tit)
title('RMSE')
ax1=gca;
ax1.XTick=1:6;
ax1.XTickLabel=tit;
subplot(2,1,2)
plot(PSNR,'linew',3)
legend(tit)
title('PSNR')
ax2=gca;
ax2.XTick=1:6;
ax2.XTickLabel=tit;
