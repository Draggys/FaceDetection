function [ scs ] = ApplyBoxDetector( Cparams, ii_im, ii_im2, x, y, L )
% x,y are top left corner of a box
% I is the integral image, and I2 the square 

    % Given a unnormalized integral image
    % Calculate all the 4 different feature types for unnormalized data
    % Apply all features to the image

%     % Get window coordinates
    xEnd = x+L-1;
    yEnd = y+L-1;
    im = zeros(L, L);
    im2 = zeros(L, L);
    ix = 1;
    for i = x : xEnd
       iy = 1;
       for j = y : yEnd
           im(ix, iy) = ii_im(i, j);
           im2(ix, iy) = ii_im2(i, j);
           iy = iy + 1;
       end
       ix = ix + 1;
    end
    
    % Feature calculation
    %mu = B(x, y, L, L, ii_im) / L^2;
    sigma = sqrt(C(x, y, L, L, ii_im2) / (L^2 - 1));
    %sigma = std(ii_im(:));
    
    fs_i = Cparams.Thetas(:, 1);
    fmat = Cparams.fmat(fs_i, :);
    fs = fmat * im(:); 
    
    %fs = fs ./ sigma; % why u no work
    
    T = size(Cparams.alphas, 1);
    score = 0;
    for t = 1 : T
       score = score + Cparams.alphas(t) * g(fs(t, :), ...
           Cparams.Thetas(t, 3), Cparams.Thetas(t, 2)); 
    end
    scs = score;
end

