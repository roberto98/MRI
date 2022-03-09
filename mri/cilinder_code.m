clear all;
close all;
clc;
% MRI source data import %
%cilinder=getimagedata('cilinder',256,256,4);
load("artifacts_cilinder.mat");
cilinder = K_space_wrap_around;
% Output imaginary and real data from FFT %
figure('Name','1) Imaginary FFT cilinder ', 'NumberTitle', 'off'),
imshow(imag(cilinder),[]);

figure('Name','2) Real FFT cilinder ', 'NumberTitle', 'off'),
imshow(abs(cilinder),[]);

% Logaritmic trasformation of FFT % 
logCilinder= log(1+abs(cilinder));
figure('Name','3) Logaritmic FFT cilinder ', 'NumberTitle', 'off'),
imshow(logCilinder,[]);

%Center IFFT%
ifftI = ifftshift(cilinder);
% Calculate IFFT % 
ifft = ifft2(ifftI);
ifft = fftshift(ifft);

% Output IFTT %
figure('Name','4) IFFT cilinder ', 'NumberTitle', 'off'),
imshow(abs(ifft),[]);

