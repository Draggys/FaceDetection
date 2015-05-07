function [ out ] = B( x, y, w, h, ii_im )
% For ii_im not normalized

    [H, W] = size(ii_im);
    if ((x+w-1) > W) || ((y+h-1) > H)
       error ('B: index out of bounds'); 
    end
        
    out = 0;
    for i = x : x+w-1
       for j = y : y+h-1
           out = out + ii_im(i, j);
       end
    end
end

