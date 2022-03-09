% https://www.sciencedirect.com/science/article/pii/S0730725X17301492

clear all;
close all;
clc;
% MRI source data import %
%brain=getimagedata('brain',256,256,1);
load('artifacts_brain.mat');
brain=K_space_radio_frequency;
% Output imaginary and real data from FFT %
figure('Name','1) Imaginary FFT brain ', 'NumberTitle', 'off'),
imshow(imag(brain),[]);

figure('Name','2) Real FFT brain ', 'NumberTitle', 'off'),
imshow(abs(brain),[]);

% Logaritmic trasformation of FFT % 
logBrain= log(1+abs(brain));
figure('Name','3) Logaritmic FFT brain ', 'NumberTitle', 'off'),
imshow(logBrain,[]);

%Center IFFT%
ifftI = ifftshift(brain);
% Calculate IFFT % 
ifft = ifft2(ifftI);
ifft = fftshift(ifft);

% Output IFTT %
figure('Name','4) IFFT brain ', 'NumberTitle', 'off'),
imshow(abs(ifft),[]);


PixelIndex = 8.6; %Valore che viene superato dai pixel corrotti
% Immagine binaria % 119,119 e 139,139 hanno value = 1
brightPixels = logBrain > PixelIndex; 
% Escludo pixel centrali che erano già bianchi
brightPixels(127:129, :)= 0; 
% Metto a 0 i pixels più chiari trovati, 0 = black
brain(brightPixels) = 0; 


% brain(119,119) = 0;
% brain(139,139) = 0;
% disp(brightPixels)
% Center IFFT %
ifftI = ifftshift(brain);
% Calculate IFFT %
ifft = ifft2(ifftI);
ifft = fftshift(ifft);
% Output of IFFT data %
figure('Name', '6) IFFT Cilinder', 'NumberTitle', 'off'),
imshow(abs(ifft), []);
colorbar();