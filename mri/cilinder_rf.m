clear all;
close all;
clc;
% MRI source data import %
%cilinder=getimagedata('cilinder',256,256,1);
load('artifacts_cilinder.mat');
cilinder=K_space_radio_frequency;
% Output imaginary and real data from FFT %
figure('Name','1) Imaginary FFT cilinder ', 'NumberTitle', 'off'),
imshow(imag(cilinder),[]);

figure('Name','2) Real FFT cilinder ', 'NumberTitle', 'off'),
imshow(abs(cilinder),[]);

% Logaritmic trasformation of FFT % 
logCilinder= log(1+abs(cilinder));
figure('Name','3) Logaritmic FFT cilinder ', 'NumberTitle', 'off'),
imshow(logCilinder,[]);
colorbar();
%Center IFFT%
ifftI = ifftshift(cilinder);
% Calculate IFFT % 
ifft = ifft2(ifftI);
ifft = fftshift(ifft);

% Output IFTT %
figure('Name','4) IFFT cilinder ', 'NumberTitle', 'off'),
imshow(abs(ifft),[]);


% Setting up threshold for spikes %
amplitudeThreshold = 8.6;
brightSpikes = logCilinder > amplitudeThreshold; % Binary image %
% disp(brightSpikes);
brightSpikes(127:129, :)= 0; % Excluding central spikes
figure('Name', '5) Spikes of Artifact Cilinder', 'NumberTitle', 'off'),
imshow(abs(brightSpikes), []);
colorbar();

cilinder(brightSpikes) = 0;
disp(cilinder);
% Center IFFT %
ifftI = ifftshift(cilinder);
% Calculate IFFT %
ifft = ifft2(ifftI);
ifft = fftshift(ifft);
% Output of IFFT data %
figure('Name', '6) IFFT Cilinder', 'NumberTitle', 'off'),
imshow(abs(ifft), []);
