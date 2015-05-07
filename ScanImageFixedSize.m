function [ dets ] = ScanImageFixedSize( Cparams, im )
% Input: Cparams
    % im: image that's not normalized
    if size(im, 3) == 3
        im = rgb2gray(im);
    end
    im = double(im);
    ii_im = cumsum(cumsum(im, 2), 1);
    ii_im2 = cumsum(cumsum(im .* im, 2), 1);
 
    L = 19;
    [H, W] = size(ii_im);
    inds = 1;
    dets = [];
    for i = 1 : H-L+1
       for j = 1 : W-L+1;
            score = ApplyBoxDetector(Cparams, ii_im, ii_im2, i, j, L);
            %score
            if score > Cparams.thresh
%                if length(dets) ~= 0
%                    if  sum(dets(dets(:,1) >= i)) > 0
%                        if sum(dets(dets(:, 1) < (j + L))) > 0
%                            continue;
%                        end
%                    end
%                end
                
               dets(inds, :) = [i, j, L, L];
               inds = inds + 1;
               % TODO: fix overlap
            end
       end
    end
end