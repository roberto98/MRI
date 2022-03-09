
clear all;
close all;
clc;

% Importo i dati MRI%
brain=getimagedata('brain',256,256,1);

% Visualizzo la parte immaginaria %
figure('Name','1) Imaginary FFT brain ', 'NumberTitle', 'off'),
imshow(imag(brain),[]);

% Visualizzo la parte reale %
figure('Name','2) Real FFT brain ', 'NumberTitle', 'off'),
imshow(abs(brain),[]);

% Trasformazione logaritmica della FFT % 
logBrain= log(1+abs(brain));
figure('Name','3) Logaritmic FFT brain ', 'NumberTitle', 'off'),
imshow(logBrain,[]);

% Calcolo la IFFT % 
ifft = ifft2(brain);
ifft = fftshift(ifft);

% Visualizzo immagine finale%
figure('Name','4) IFFT brain ', 'NumberTitle', 'off'),
imshow(abs(ifft),[]);