function [ i ] = To1D( x, y, rows )
%To1D converts 2D index to 1D index

    i = rows * (y - 1) + x;
end

