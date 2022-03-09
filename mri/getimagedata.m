function Kspace = getimagedata(filename, Nx, Ny, echo)
% This opens GE Data Files and extracts the Image data by brute force.
% Echo is the echo number or 1 if there is only one echo.
% Modify it at your peril.
fid=fopen(filename,'r','b'); % dont overwrite data
% This will work only with 256*256 Images
if Nx ==256 & Ny ==256
   disp( filename );
else
   error( 'This will work only with 256*256 Images');
end

fseek(fid,39984+(echo-1)*256*256*2*2+echo*256*2*2,'bof');    
R=fread(fid,[256 256],'short',2);
fseek(fid,39984+(echo-1)*256*256*2*2+echo*256*2*2+2,'bof');
I=fread(fid,[256 256],'short',2);
M=R+i*I;

%fseek(fid,39984+256*2*2,'bof'); % The data size of a row is 256*2*2 
% [R, numReal]=fread(fid,[256,256],'short',2); % LHS [R, count] count is optional. 
% Short is platform specific. int16 is probably better.  
% Last is skip 2 bytes. Could speed this up.
% fseek(fid,39984+256*2*2+2,'bof');
% [I, numImag]=fread(fid,[256,256],'short',2);
% [numReal, numImag]
fclose(fid);

% Now get rid of the sign inversion between sucessive phase encodes
m=fftshift(fft2(fftshift(M))); % Make an image
m=[m(:,[129:256]),m(:,[1:128])]; % shift columns only
m=flipud(m); % Make it right side up
% The 1st and 3rd echoes are flipped left-to-
% right.  This corrects for that.
if rem(echo,2) ~= 0,
   m=fliplr(m);
end
% This should look ok
% imagesc(abs(m));
% colormap(gray);
% Now make a corrected data array
M=fftshift(ifft2(fftshift(m)));
R=real(M);
I=imag(M);
Kspace = M;
% fseek(fid,39984+256*2*2,'bof');
% fsunt=fwrite(fid,R,'short',2);   % Now OVERWRITE the data???
% fseek(fid,39984+256*2*2+2,'bof');
% count2=fwrite(fid,I,'short',2);
% close(fid);
