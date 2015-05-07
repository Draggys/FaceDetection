function [ sigma ] = Sigma( x, y, w, h, ii_im )
% For ii_im not normalized

    if w ~= h
       error('Sigma: w must equal h'); 
    end
    
    L = w;
    u = B(x, y, w, h, ii_im) / L^2;
    sigma2 = 0;
    for i = x : x+w-1
       for j = y : y+h-1
           sigma2 = sigma2 + ii_im(i, j)^2 - L^2 * u^2;
       end
    end
    
    sigma = sqrt(sigma2);
end

