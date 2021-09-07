clc; clear all; close all; 

% read Image to double
ImageMatrix = im2double( imread('Bird 1.tif' ));
[M, N] = size(ImageMatrix);

% creating array for DFT & IDFT
PaddMatrix = zeros(2*M, 2*N);
DFTrow = 2*M;
DFTcol = 2*N;

% Padding the image
PaddMatrix(1:512, 1:512) = ImageMatrix;
figure();  imshow(ImageMatrix);  title('original image');
figure();  imshow(PaddMatrix);  title('padded image');

% centering -> multiply (-1)^(x+y)
CenterMatrix = zeros(2*M, 2*N);
powerVector = [0 : 2*M-1];
PowerMatrix = [ ];
temp = repmat(powerVector, 2*M, 1);
PowerMatrix = temp + temp';
CenterMatrix = PaddMatrix.*((-1).^(PowerMatrix));
figure();  imshow(CenterMatrix);  title('pre processed image for calculating DFT');

% 2D Fourier transform
DFTMatrix = fft2(CenterMatrix); 
figure();  imshow(DFTMatrix);  title('2D DFT of image before Laplacian');

% Log scaling
DFTmag = abs(DFTMatrix);
figure();  imshow(DFTmag, [ ]);  title('2D DFT of image');
LogDFTmag = log(1 + DFTmag);
MaxDFT = max( max(LogDFTmag) );
ReMagDFT = (LogDFTmag*255) / MaxDFT;
figure();  imshow(ReMagDFT, [ ]);  title('2D DFT of image (Log)');

% Design filter
% implement (u,v) graph
U_V_Vector = [ [-M:1:-1] [0 : M-1] ];
U_V_Matrix = [ ];
temp2 = repmat(U_V_Vector, 2*M, 1);
U_V_Matrix = (temp2.^(2)) + (temp2'.^(2));
H_Matrix = U_V_Matrix/(max(max(U_V_Matrix)));
figure();  imshow(abs(H_Matrix));  title('H Matrix');

% Filtering
G_Matrix = DFTMatrix.*H_Matrix;
figure();  imshow(abs(G_Matrix), [ ]);  title('Magnitude G Matrix (after Laplacian)');
figure();  imshow(log(1+abs(G_Matrix)), [ ]);  title('Magnitude G Matrix (after Laplacian)(log)');

% Top 25 Hz
% largest 25 magnitude -> get their frequency
% Log scaling
DFTmag2 = abs(G_Matrix);
LogDFTmag2 = log(1 + DFTmag2);
MaxDFT2 = max( max(LogDFTmag2) );
ReMagDFT2 = (LogDFTmag2*255) / MaxDFT2;
U_vector = zeros(25,1);
V_vector = zeros(25,1);
MagMatrix = zeros(25,1);
for i = 1:25
    [R, C] = find(ReMagDFT2 == max(max(ReMagDFT2)) );
    MagMatrix(i) = ReMagDFT2(R(1), C(1));
    U_vector(i) = R(1);  % choose the first one, if two mag same
    V_vector(i) = C(1);
    ReMagDFT2(R(1), C(1)) = -1;
end
Large25 = [U_vector V_vector];


% calculate Inverse 2D DFT
g_matrix = ifft2(G_Matrix);
figure();  imshow(g_matrix);  title('After Inverse 2D DFT');

% Post preprocess
% centering again -> multiply (-1)^(x+y)
CenterMatrix2 = zeros(2*M, 2*N);
CenterMatrix2 = real(g_matrix).*((-1).^(PowerMatrix));
%figure();  imshow(CenterMatrix2);  title('post processed image for calculating DFT');
OutputMatrix = (CenterMatrix2(1:512, 1:512));
figure();  imshow(OutputMatrix*255);  title('Output Image');
