function [ dets ] = ScanImageOverScale( Cparams, im, min_s, max_s, step_s, vargin )
% vargin(1) can specify a threshhold for the strong classifyer
% if not then the threshold in Cparams is used
    if size(im, 3) == 3
        im = rgb2gray(im);
    end
    im = double(im);
    
    interval = min_s:step_s:max_s;
    dets = [];
    for i = 1 : length(interval)
       j = interval(i);
       imR = imresize(im, j);
       if nargin == 6
           tmpDets = ScanImageFixedSize(Cparams, imR, vargin(1));
       else
           tmpDets = ScanImageFixedSize(Cparams, imR);
       end
       dets = [dets; tmpDets/j];
    end
end

