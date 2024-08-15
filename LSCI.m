% PHSC 480: Advanced Physics Lab - Laser Speckle Contrast Imaging
% project
% Alexandra Shellans
% Created: 3/8/24

% Description:
% This function takes as its argument a raw laser speckle photo in the form
% of its file name and processes its contrast image for LSCI analysis. The
% photo is prepared by loading the photo as a matrix of pixels and 
% converting the image to grayscale. Then, for each pixel in the image, a 
% window of 7x7 pixels is generated. For each generated window, the mean
% and standard deviation of the intensity of each pixel is calculated, and
% their ratio is computed and put into a new matrix K of the same size of
% the original photo. This contrast matrix K is then converted to and 
% processed as an image and converted to grayscale, which represents the
% contrast image of the raw speckle image.

function [] = LSCI(filename)

% Load photo
A = imread(filename);
[numrows, numcols, n] = size(A);

% Convert A to grayscale
G = .2989*A(:,:,1)+.5870*A(:,:,2)+.1140*A(:,:,3);
figure
colormap(gray(256));
image(G)
title('Raw Speckle Image')

% Calculate contrast
G = double(G);
K = zeros(numrows-6, numcols-6);

% Loop through each pixel in the image
for row = 4:numrows-4
    for col = 4:numcols-4
        window = G(row-3:row+3,col-3:col+3);
        m = mean(window, 'all');
        sd = std(window, 0, 'all');
        K(row, col) = sd/m;
    end
end

% Convert K to image
C = K*256; 
C = uint8(C);

% Generate contrast image
figure
colormap(gray(256));
image(C)
title('Speckle Contrast Image')

end
