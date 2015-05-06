function [ im, ii_im ] = LoadIm( im_fname, varargin )
%LoadIm Load image
%   Input: 
    % 1) Filename of an image
    % 2) if varargin{1} is set to 1, sanity check is enabled
%   Output: Two arrays
    % 1) Normalized version of the pixel data of the image
    % 2) It's integral image
    
%     % Read in image
%     im = double(imread(im_fname));
%     [x, y] = size(im);
%     
%     % Image normalization orig
%     im = im(:);
%     mu = mean(im);
%     sigma = std(im);
%     if sigma == 0
%        sigma = 1; 
%     end
%     im = (im - mu) / sigma;
% 
%     dflag = 0;
%     if nargin > 1
%        dflag = 1;
%     end
%     % Sanity check
%     if dflag == 1
%         if (round(mean(im)) == 0) && (round(std(im)) == 1)
%            disp('[Success] LoadIm (Sanity check): im is normalized');
%         else
%             msg = '[Fail] LoadIm (Sanity check): im is not normalized';
%             error(msg);
%         end   
%     end
%     
%     % Reshape back to original dimensions
%     im = reshape(im, [x, y]);
%     
%     % Compute the integral image
%     ii_im = cumsum(cumsum(im, 1), 2);

   im = double(imread(im_fname));
    mu = mean(im(:));
    sd = std(im(:));
    if sd == 0
       sd = 1; 
    end
    n_im = (im - mu) / sd;
    
    ii_im = cumsum(cumsum(n_im, 2));
    im = n_im;
end

