function [ ftype_vec ] = VecFeature( ftype, W, H )
%VecFeature
%   Input: parameters of the feature type
    % ftype: vector with all the features ex: [1, x, y, w, h]
    % W, H: width and height of image
%   Output: row vector
    % row vector ftype_vec s.t ftype_vec * ii_im(:) computes the feature on the
    % original image im
    % Since VecBoxSum returns NaN if inputis faulty this function will also
    % output NaN if input is faulty.

    type = ftype(1);
    x = ftype(2);
    y = ftype(3);
    w = ftype(4);
    h = ftype(5);
    
    % Wants to subtract the white boxes in Vioala & Jones features
    if type == 1 
        ftype_vec = VecBoxSum(x, y, w, h, W, H) - VecBoxSum(x, y + h, w, h, W, H);
    elseif type == 2
        ftype_vec = VecBoxSum(x + w, y, w, h, W, H) - VecBoxSum(x, y, w, h, W, H);
    elseif type == 3
        ftype_vec = VecBoxSum(x + w, y, w, h, W, H) - VecBoxSum(x, y, w, h, W, H) - ...
            VecBoxSum(x + 2 * w, y, w, h, W, H);
    elseif type == 4
        ftype_vec = VecBoxSum(x+w, y, w, h, W, H) + VecBoxSum(x, y + h, w, h, W, H) - ...
            VecBoxSum(x, y, w, h, W, H) - VecBoxSum(x + w, y + h, w, h, W, H);
    end
end

