function [ scs ] = ApplyBoxDetector( Cparams, ii_im, ii_im2, x, y, L )
% x,y are top left corner of a box
    
    im = ii_im(y:y+L-1, x:x+L-1);
    
    mu = B(x, y, L, L, ii_im) / (L * L);
    sigma2 = (B(x, y, L, L, ii_im2) - L * L * mu * mu) / (L*L - 1);
    sigma = sqrt(sigma2);
    
    fs_i = Cparams.Thetas(:, 1);
    fmat = Cparams.fmat(fs_i, :);
    fs = fmat * im(:); 
%     
%     ftypes = Cparams.all_ftypes(fs_i, :);
%     for i = 1 : size(fs_i, 1)
%        if ftypes(i, 1) == 3
%            fs(i) = fs(i) + ftypes(i, 1) * L * L * mu;
%        end
%     end
%     fs = fs / sigma;

    ftypes = Cparams.all_ftypes(fs_i, :);
    ftype3 = ftypes(:, 1) == 3;
    fs = fs + ftype3 * L * L * mu;
    fs = fs / sigma;
%     
%     
%     T = size(Cparams.alphas, 1);
%     score = 0;  
%     for t = 1 : T
%        score = score + Cparams.alphas(t) * g(fs(t, :), ...
%            Cparams.Thetas(t, 3), Cparams.Thetas(t, 2)); 
%     end
%      scs = score;
%      

    p = Cparams.Thetas(:, 3);
    scs = sum(Cparams.alphas .* ((p .* fs < p .* Cparams.Thetas(:,2)) * 2 - 1));
end
