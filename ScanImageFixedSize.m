function [ dets ] = ScanImageFixedSize( Cparams, im, vargin )
% Input: Cparams
    % im: image that's not normalized
    if size(im, 3) == 3
        im = rgb2gray(im);
    end
    im = double(im); 
    im = im / 255;
    ii_im = cumsum(cumsum(im, 2), 1);
    ii_im2 = cumsum(cumsum(im .* im, 2), 1);
 
    theta = Cparams.thresh;
    if nargin == 3
       theta = vargin(1); 
    end
    
    L = 19;
    inds = 1;
    dets = [];
    
    fs_i = Cparams.Thetas(:, 1);
    fmat = Cparams.fmat(fs_i, :);
    ftypes = Cparams.all_ftypes(fs_i, :);
    w = ftypes(:, 4);
    h = ftypes(:, 5);
    ftype3 = ftypes(:, 1) == 3;
    p = Cparams.Thetas(:, 3);
    pp = Cparams.Thetas(:, 2);
    L2 = L * L;
    for x = 1 : size(ii_im, 2)-L+1
       for y = 1 : size(ii_im,1)-L+1;
            %score = ApplyBoxDetector(Cparams, ii_im, ii_im2, i, j, L);
            
            % rep applybox det start
            im2 = ii_im(y:y+L-1, x:x+L-1);

            mu = B(x, y, L, L, ii_im) / (L2);
            sigma2 = (B(x, y, L, L, ii_im2) - L2 * mu * mu) / (L2 - 1);
            sigma = sqrt(sigma2);

            fs = fmat * im2(:); 
            
            fs = fs + ftype3 .* w .* h * mu;
            fs = fs / sigma;
            
            score = sum(Cparams.alphas .* ((p .* fs < p .* pp) * 2 - 1));
            % rep applybox det end
            
            if score > theta;
               dets(inds, :) = [x, y, L, L];
               inds = inds + 1;
            end
       end
    end
end