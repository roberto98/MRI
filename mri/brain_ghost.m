% https://www.sciencedirect.com/science/article/pii/S0730725X17301492

clear all;
close all;
clc;
% MRI source data import %
%brain=getimagedata('brain',256,256,1);
load('artifacts_brain.mat');
brain=K_space_quadrature_ghost;
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
ifft = ifft2(brain);
ifft = fftshift(ifft);

% Output IFTT %
figure('Name','4) IFFT brain ', 'NumberTitle', 'off'),
imshow(abs(ifft),[]);



% Fix artifacts % 
brainFixed = complex(real(brain), imag(brain)*2);

% Center IFFT %
ifftI = ifftshift(brainFixed);
% Calculate IFFT %
ifft = ifft2(ifftI);
ifft = fftshift(ifft);
% Output of IFFT data %
figure('Name', '7) IFFT Fixed Artifsct Brain', 'NumberTitle', 'off'),
imshow(abs(ifft), []);