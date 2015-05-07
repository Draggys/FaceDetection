function [ c ] = C( x, y, w, h, ii_im )
% For ii_im not normalized

    if w ~= h
       error('Sigma: w must equal h'); 
    end
    
    L = w;
    u = B(x, y, w, h, ii_im) / L^2;
    c = 0;
    for i = x : x+w-1
       for j = y : y+h-1
           c = c + ii_im(i, j) - L^2 * u^2;
       end
    end
end

