function [ out ] = B( x, y, w, h, ii_im )
    if x == 1 && y == 1
        out = ii_im(y+h-1, x+w-1);
    elseif ( x == 1)
        out = ii_im(y+h-1, x+w-1) - ii_im(y-1, x+w-1);
    elseif ( y == 1 )
        out = ii_im(y+h-1, x+w-1) - ii_im(y+h-1, x-1);
    else
        out = ii_im(y+h-1, x+w-1) - ii_im(y-1, x+w-1) - ii_im(y+h-1,x-1) + ii_im(y-1,x-1);
    end
end

