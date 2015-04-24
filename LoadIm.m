function [ im, ii_im ] = LoadIm( im_fname, dflag )
%LoadIm Load image
%   Input: 
    % 1) Filename of an image
    % 2) if dflag is set to 1, testing is enabled
%   Output: Two arrays
    % 1) Normalized version of the pixel data of the image
    % 2) It's integral image
    
    % Read in image
    im = double(imread(im_fname));
    [x, y] = size(im);
    
    % Image normalization
    im = im(:);
    mu = mean(im);
    sigma = std(im);
    for i = 1 : length(im)
        im(i) = (im(i) - mu) / sigma;
    end
    
    % Sanity check
    if dflag == 1
        if (round(mean(im)) == 0) && (round(std(im)) == 1)
           disp('[Success] LoadIm (Sanity check): im is normalized');
        else
            msg = '[Fail] LoadIm (Sanity check): im is normalized';
            error(msg);
        end   
    end
    
    % Reshape back to original dimensions
    im = reshape(im, [x, y]);
    
    % Compute the integral image
    ii_im = cumsum(cumsum(im')');
end

