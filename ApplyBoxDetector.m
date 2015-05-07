function [ scs ] = ApplyBoxDetector( Cparams, ii_im, ii_im2, x, y, L )
% x,y are top left corner of a box

    im = ii_im(x:x+L-1, y:y+L-1);
    
    mu = sum(sum(ii_im(x:x+L-1, y:y+L-1))) / (L * L);
    sigma2 = sum(sum(ii_im2(x:x+L-1, y:y+L-1) - L * L * mu * mu)) / (L*L - 1);
    sigma = sqrt(sigma2);
    
    fs_i = Cparams.Thetas(:, 1);
    fmat = Cparams.fmat(fs_i, :);
    fs = fmat * im(:); 
    fs = fs ./ sigma;
    
    p = Cparams.Thetas(:,3);
    scs = sum(p .* fs < p * Cparams.thresh);
end