function [ dets ] = ScanImageFixedSize( Cparams, im )
% Input: Cparams
    % im: image that's not normalized
    if size(im, 3) == 3
        im = rgb2gray(im);
    end
    im = double(im);
    ii_im = cumsum(cumsum(im, 1), 2);
    ii_im2 = cumsum(cumsum(im .* im, 1), 2);
 
    L = 19;
    [H, W] = size(im);
    inds = 1;
    dets = [];
    for i = 1 : H-L+1
       for j = 1 : W - L+1;
            score = ApplyBoxDetector(Cparams, ii_im, ii_im2, i, j, L);
            %score
            if score > Cparams.thresh
               dets(inds, :) = [i, j, L, L];
               inds = inds + 1;
               % TODO: fix overlap
            end
       end
    end
end