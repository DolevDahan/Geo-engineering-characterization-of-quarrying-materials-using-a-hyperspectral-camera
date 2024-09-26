function [NormalizedMatrix, EuclideanDistanceMatrix] = EuclideanNormalize(DataCubeMatrix)
% EuclideanNormalize - Normalizes the pixel vectors of a hyperspectral data cube.
%
% This function takes a hyperspectral data cube as input and normalizes each
% pixel vector in the cube by its Euclidean distance (L2 norm). The output
% is the normalized cube and a matrix containing the Euclidean distances
% for each pixel before normalization. Normalization is an important step in
% hyperspectral image analysis, particularly when the goal is to remove
% magnitude differences between spectra for better feature extraction and comparison.
%
% Usage:
%   [NormalizedMatrix, EuclideanDistanceMatrix] = EuclideanNormalize(DataCubeMatrix)
%
% Input:
%   DataCubeMatrix - A hyperspectral data cube (double array), provided as a 3D matrix of size
%                    (rows x cols x bands), where each pixel contains spectral
%                    information across multiple bands (wavelengths).
%
% Output:
%   NormalizedMatrix - A hyperspectral data cube where each pixel vector has
%                      been normalized to unit length (i.e., the Euclidean distance 
%                      of each vector is 1).
%   EuclideanDistanceMatrix - A matrix of size (rows x cols) containing the
%                             original Euclidean distances of each pixel vector
%                             before normalization.
%
% Example:
%   % Assuming DataCube_Rock45d is a 3D matrix of hyperspectral data (rows x cols x bands)
%   [NormalizedMatrix_Rock45d, EuclideanDistanceMatrix_Rock45d] = EuclideanNormalize(DataCube_Rock45d);
%
% Details:
%   - Normalization is performed for each pixel vector by dividing the vector by
%     its Euclidean norm.
%   - Pixels with zero Euclidean distance (i.e., zero vectors) are left unchanged.
%   - Euclidean distance is calculated as the square root of the sum of the squared
%     pixel values across all bands.

% Ensure the DataCubeMatrix is a 3D matrix and extract its dimensions
[rows, cols, bands] = size(DataCubeMatrix); 

% Initialize the output matrices
NormalizedMatrix = zeros(rows, cols, bands); % To store normalized pixel vectors
EuclideanDistanceMatrix = zeros(rows, cols); % To store Euclidean distances of original vectors

% Normalize each pixel vector
for row = 1:rows
    for col = 1:cols
        % Extract the pixel vector from the hyperspectral cube
        pixelVector = double(squeeze(DataCubeMatrix(row, col, :)));
        
        % Calculate the Euclidean distance (L2 norm) of the pixel vector
        EuclideanDistance = sqrt(sum(pixelVector .^ 2));
        EuclideanDistanceMatrix(row, col) = EuclideanDistance;
        
        % Normalize the pixel vector, if the Euclidean distance is not zero
        if EuclideanDistance > 0
            NormalizedMatrix(row, col, :) = pixelVector / EuclideanDistance;
        end
    end
end
end
