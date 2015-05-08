function [ dets ] = ScanImageFixedSize( Cparams, im, vargin )
% Input: Cparams
    % im: image that's not normalized
    if size(im, 3) == 3
        im = rgb2gray(im);
    end
    im = double(im);
    ii_im = cumsum(cumsum(im, 2), 1);
    ii_im2 = cumsum(cumsum(im .* im, 2), 1);
 
    theta = Cparams.thresh;
    if nargin == 3
       theta = vargin(1); 
    end
    
    L = 19;
    inds = 1;
    dets = [];
    for i = 1 : size(ii_im, 2)-L+1
       for j = 1 : size(ii_im,1)-L+1;
            score = ApplyBoxDetector(Cparams, ii_im, ii_im2, i, j, L);
            if score > theta;
               dets(inds, :) = [i, j, L, L];
               inds = inds + 1;
            end
       end
    end
end