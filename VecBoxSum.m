function [ b_vec ] = VecBoxSum( x, y, w, h, W, H )
%VexBoxSum
%   Input: 
    % (x, y) denoes the upper left pixel coordinates of the rectangle
       % x, y > 2
    % w, h denotes the width and height of the rectangle
    % W, H denotes the dimensions of the integral image
%   Output: A row vector b_vec of size 1 x np
    % where np is the number of pixels
    % b_vec are all zero except for 4 of its entries
    % b_vec can be used to compute the sum of pixel values within
    % a rectangular region defined by (x, y, w, h) : b_vec * ii_im(:)
%   If boundary box is invalid NaN will be returned.

    % Invalid rectangle
    xMax = x + w - 1;
    yMax = y + h - 1;
    if xMax > W || yMax > H || x < 2 || y < 2
        b_vec = NaN;
        return
    end
    x = x - 1;
    y = y - 1;
    
    % Create b_vec
    b_vec = zeros(1, W * H);
    b_vec(To1D(y, x, W)) = 1;
    b_vec(To1D(yMax, x, W)) = -1;
    b_vec(To1D(y, xMax, W)) = -1;
    b_vec(To1D(yMax, xMax, W)) = 1;
end

