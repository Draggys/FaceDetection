function [ out ] = B( x, y, w, h, ii_im )
% For ii_im not normalized

    out = 0;
    for i = x : x+w-1
       for j = y : y+h-1
           out = out + ii_im(i, j);
       end
    end
end

