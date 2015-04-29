function [ fpic ] = MakeFeaturePic( ftype, W, H )
%MakeFeaturePic make an image representing a feature
    % Input:
        % ftype: [1, x, y, w, h], where first element belongs to {1, 2, 3, 4}
        % W, H, width and height of the image
    % Output:
        % fpic, a matrix
   
    fpic = zeros(H, W);
    
    type = ftype(1);
    x = ftype(2);
    y = ftype(3);
    w = ftype(4);
    h = ftype(5);
   
    if type == 1 
        fpic(y : y + h - 1, x : x + w - 1) = -1;
        fpic(y + h : y + 2 * h - 1, x : x + w - 1) = 1;
    elseif type == 2
        fpic(y : y + h - 1, x : x + w - 1) = 1;
        fpic(y : y + h - 1, x + w : x + 2 * w - 1) = -1;
    elseif type == 3
        fpic(y : y + h - 1, x : x + w - 1) = 1;
        fpic(y : y + h - 1, x + w : x + 2 * w - 1) = -1;
        fpic(y : y + h - 1, x + 2 * w : x + 3 * w - 1) = 1;
    elseif type == 4
        fpic(y : y + h - 1, x : x + w - 1) = 1;
        fpic(y : y + h - 1, x + w : x + 2 * w - 1) = -1;
        fpic(y + h : y + 2 * h - 1, x : x + w - 1) = -1;
        fpic(y + h : y + 2 * h - 1, x + w : x + 2 * w - 1) = 1;
    end
    
end

