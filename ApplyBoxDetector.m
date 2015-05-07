function [ scs ] = ApplyBoxDetector( Cparams, ii_im, mu, sigma, x, y, L )
% x,y are top left corner of a box

    xEnd = x+L-1;
    yEnd = y+L-1;
    for i = x : xEnd
       for j = y : yEnd
           im(i, j) = ii_im(i, j);
       end
    end
    
    [X, Y] = size(ii_im);
    if xEnd > X && yEnd > Y
       error('Index out of bounds'); 
    end

    fmatSize = size(Cparams.fmat)
    imSize = size(im)
    fs = Cparams.fmat * im(:);
    T = size(Cparams.alphas, 1);
    score = 0;
    for t = 1 : T
       score = score + Cparams.alphas(t) * g(fs(Cparams.Thetas(t, 1), :), ...
           Cparams.Thetas(t, 3), Cparams.Thetas(t, 2)); 
    end
    scs = score;


end

