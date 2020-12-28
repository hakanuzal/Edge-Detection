function varargout = Proje(varargin)
% PROJE MATLAB code for Proje.fig
%      PROJE, by itself, creates a new PROJE or raises the existing
%      singleton*.
%
%      H = PROJE returns the handle to a new PROJE or the handle to
%      the existing singleton*.
%
%      PROJE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJE.M with the given input arguments.
%
%      PROJE('Property','Value',...) creates a new PROJE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Proje_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Proje_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help Proje
% Last Modified by GUIDE v2.5 03-Jan-2020 21:45:00
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Proje_OpeningFcn, ...
                   'gui_OutputFcn',  @Proje_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before Proje is made visible.
function Proje_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Proje (see VARARGIN)
% Choose default command line output for Proje
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Proje wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% --- Outputs from this function are returned to the command line.
function varargout = Proje_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
handles.output = hObject;
ss = ones(300,400);
axes(handles.axes1);
imshow(ss);
%Sablon ekleme
axes(handles.axes4);
imshow('sablon.png');
%Güncelleme kollarý yapýsý
guidata(hObject, handles);

% --- Executes on button press in yukle.
function yukle_Callback(hObject, eventdata, handles)
% hObject    handle to yukle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
[filename,path]=uigetfile({ '*.png; *.jpg; *.bmp; *.tif' }, ... 
                          'Resim Dosyasý Seçime');
selectedfile = fullfile(path,filename);
if filename == 0
    error('Hata !!! Lütfen Bir Resim Seçiniz.');
end

resim = imread(filename);
axes(handles.axes1)
imshow(filename)
% %set(gca,'xtick',[])
title(filename)
handles.ImgData1 = resim;
guidata(hObject,handles);

function resimadi_Callback(hObject, eventdata, handles)
% hObject    handle to resimadi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of resimadi as text
%        str2double(get(hObject,'String')) returns contents of resimadi as a double
% --- Executes during object creation, after setting all properties.
function resimadi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resimadi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function resimuzantisi_Callback(hObject, eventdata, handles)
% hObject    handle to resimuzantisi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of resimuzantisi as text
%        str2double(get(hObject,'String')) returns contents of resimuzantisi as a double
% --- Executes during object creation, after setting all properties.
function resimuzantisi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resimuzantisi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes during object creation, after setting all properties.
function RMSE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to RMSE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global RMSEDATA PSNRDATA MSEDATA SEDATA
% if true 
%     Figures = findobj('Type','Figure','-not','Tag',...
%               get(handles.output,'Tag'));
%           close(Figures)
% end
I1 = handles.ImgData1;
if ndims(I1) == 3
   I1 = rgb2gray(I1);
end
I1 = im2double(I1); %// Convert to double
[M,N] = size(I1);
% Matrislere sýfýrlarla ön yer ayýrma
% Hesaplama için double duyarlýklý görüntü oluþturma
% C = double();
Sx= {[0 0 0;0 1 0;0 0 -1], [-1 -1 -1;0 0 0;1 1 1], [-1 -2 -1;0 0 0;1 2 1]};

Sy= {[0 0 0;0 0 1;0 -1 0], [-1 0 1;-1 0 1;-1 0 1], [-1 0 1;-2 0 2;-1 0 1]};
% figure
% imshow(I1, []);
% title( 'Orijinal Görüntü' );
% set(gcf, 'Position', get(0,'Screensize'));
% set(gcf, 'name','Kenar Tespiti Yapýlmýþ Resimler',...
%     'numbertitle','off')
   tit = {'Roberts', ' Prewitt', ' Sobel', 'Canny', 'LoG', 'ZC'};
   
   num = length(tit);
   MSE = zeros(num); RMSE = zeros(num); PSNR = zeros(num);
     EdgeMatrix = {};
for i=1:num
    if i<= 3
       EdgeMatrix{i} = EdgeDetection(i,I1,Sx{i},Sy{i});
    elseif i==4
       EdgeMatrix{i} = canny_code(I1);
    elseif i==5
       EdgeMatrix{i} = LoG(I1);
    elseif i==6
       EdgeMatrix{i} = ZC(I1);
    end
figure
imshow(EdgeMatrix{i}, []);
title( [tit{i} ' Gradyent Filtrelenmiþ Görüntü'] );
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


assignin('base','RMSE',RMSE)
assignin('base','MSE',MSE)
assignin('base','SE',SE)
assignin('base','PSNR',PSNR)

RMSE
PSNR

handles.RMSEdata = RMSE;
handles.MSEdata = MSE;
handles.SEdata = SE;
handles.PSNRdata = PSNR;
