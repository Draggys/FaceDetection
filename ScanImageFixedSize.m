function [ dets ] = ScanImageFixedSize( Cparams, im )
% Input: Cparams
    % im: image that's not normalized
    if size(im, 3) == 3
        im = rgb2gray(im);
    end
    im = double(im);
    ii_im = cumsum(cumsum(im, 1), 2);
    ii_im2 = cumsum(cumsum(im .* im, 1), 2);
 
%     L = 19;
%     mu = B(1, 1, L, L, ii_im) / L^2;
%     sigma = Sigma(1, 1, L, L, ii_im);
%     score = ApplyBoxDetector(Cparams, ii_im, mu, sigma, 1, 1, L);
%     
%     
    L = 19;
    [H, W] = size(im);
    inds = 1;
    for i = 1 : H-L+1
       for j = 1 : W - L+1;  
            %mu = B(i, j, L, L, ii_im) / L^2;
            %sigma = Sigma(i, j, L, L, ii_im);
            % Change this to fast mu and sigma
            mu = mean(ii_im(:));
            sigma = std(ii_im(:));
            score = ApplyBoxDetector(Cparams, ii_im, mu, sigma, i, j, L);
            if score > Cparams.thresh
               dets(inds, :) = [i, j, L, L];
               inds = inds + 1;
            end
       end
    end
    dets = dets(1:inds-1, :);
end