function [CalibratedRock, WavelengthAxis] = Calibration_FX10(RockCube, WhiteREFCube, DarkREFCube)
    % Calibration_FX10 - Calibrates hyperspectral data by subtracting dark references
    % and using the white light reflectance as a reference.
    %
    % Syntax: [CalibratedRock, WavelengthAxis] = Calibration_FX10(RockCube, WhiteREFCube, DarkREFCube)
    %
    % Inputs:
    %    RockCube - A hypercube representing the hyperspectral data of the rock sample.
    %               It should include the fields:
    %               'DataCube': 3D array of size (rows, cols, bands)
    %               'Wavelength': 1D array of wavelength values corresponding to the bands.
    %    WhiteREFCube - A hypercube representing the reflection of the light that shines on the rocks.
    %                   This is the white reference cube used for calibration. It should be 
    %                   photographed at the same time as the rock, under the same lighting 
    %                   conditions and temperature. 
    %                   'DataCube' field is required, containing the 3D data.
    %    DarkREFCube - A hypercube representing the dark image taken at a closed aperture 
    %                  (no light entering), representing the thermal noise of the sensor.
    %                  It should also be photographed together with the rock, under similar 
    %                  temperature conditions to ensure the accuracy of thermal noise correction.
    %                  'DataCube' field is required, containing the 3D data.
    %
    % Outputs:
    %    CalibratedRock - 3D array of the calibrated rock hyperspectral data, where the
    %                     dark reference has been subtracted and the data is corrected
    %                     using the white light reflectance as a reference.
    %    WavelengthAxis - 1D array of wavelengths corresponding to the bands in the
    %                     hyperspectral cube. It is extracted from the RockCube.
    %
    % Description:
    %    This function performs the calibration of hyperspectral data using a dark
    %    reference and a white reference. It subtracts the dark reference from both
    %    the rock and white reference cubes, then uses the dark-corrected white reference 
    %    cube to adjust the rock's spectral reflectance data. The white reference cube represents 
    %    the light source reflection, which is used to correct the spectral values of the rock.
    %    The function handles cases where the input cubes are not in double precision and ensures 
    %    the results are non-negative by adjusting for any offsets.
    %
    % Notes:
    %    - The white reference cube should represent the reflection of the light source
    %      used to illuminate the rock sample. It is essential to capture it at the same
    %      time as the rock under the same lighting and temperature conditions.
    %    - The dark reference cube should represent thermal noise from the sensor, which
    %      can be captured by photographing with a closed aperture. Ensure the dark reference 
    %      is taken at a temperature as close as possible to the temperature during the rock 
    %      and white reference capture.
    %    - Zeros in the white reference cube are replaced by a small value to avoid
    %      division by zero errors during calibration.
    %
    % Example:
    %    [CalibratedRock, WavelengthAxis] = Calibration_FX10(RockCube, WhiteREFCube, DarkREFCube);
    
    % Ensure data is in double precision
    DarkREFData = double(DarkREFCube.DataCube);
    WhiteREFData = double(WhiteREFCube.DataCube);
    RockData = double(RockCube.DataCube);
    WavelengthAxis = RockCube.Wavelength;

    % Calculate the 2D dark reference matrices by averaging along rows
    Dark2DMatrixForWhite = mean(DarkREFData, 1);
    Dark2DMatrixForRock = mean(DarkREFData, 1);
    
    % Determine the number of rows in the white and rock data cubes
    [WhiteRows, ~, ~] = size(WhiteREFData);
    [RockRows, ~, ~] = size(RockData);
    
    % Ensure compatibility by taking the minimum number of rows between rock and white cubes
    Rows = min([RockRows, WhiteRows]);
    
    % Subtract dark reference matrices from white and rock data cubes
    for i = 1:Rows
        WhiteREFData(i,:,:) = WhiteREFData(i,:,:) - Dark2DMatrixForWhite;
        RockData(i,:,:) = RockData(i,:,:) - Dark2DMatrixForRock;
    end
    
    % Adjust for any remaining offsets by subtracting the minimum value
    WhiteREFData = WhiteREFData - min(WhiteREFData(:));
    RockData = RockData - min(RockData(:));
    
    % Avoid division by zero by replacing zeros in the white reference data
    WhiteREFData(WhiteREFData == 0) = 1e-10;
    
    % Perform the calibration by dividing the dark-corrected rock data by the white reference data
    CalibratedRock = RockData(1:Rows,:,:) ./ WhiteREFData(1:Rows,:,:);
end
