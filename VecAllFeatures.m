function [ fmat ] = VecAllFeatures( all_ftypes, W, H )
% VecAllFeatures computes a feature matrix
    % Input: all_ftypes, matrix with features, where a row is a feature
       % W, H are the dimensions of the image
    % Output: fmat of size nf x W*H where each row is a feature
    
    fmat = zeros(size(all_ftypes, 1), W * H);
    for i = 1 : size(all_ftypes, 1)
        fmat(i, :) = VecFeature(all_ftypes(i, :), W, H);
    end

    fmat = sparse(fmat);
end
