function [ ii_ims ] = LoadImDataDir( dirname, varargin )
%LoadImDataDir load images from a directory
    % Input: 
        % dirname, path to dir containing images
        % optional varargin, specify #images to load
    % Output: Matrix of integral images stored as columns
    
    images = dir([dirname '*.bmp']);
    len = size(images, 1);
    
    if nargin > 1
       len = varargin{1};
    end
    
    for i = 1 : len
        [im, ii_im] = LoadIm(images(i).name);
        ii_ims(:, i) = ii_im(:);
    end   
end