close all;
clear all;
clc;

addpath('Data\TrainingImages\FACES\');

% Debug Point 1
[im, ii_im] = LoadIm('face00001.bmp', 1);
dinfo1 = load('Data\DebugInfo\debuginfo1.mat');
eps = 1e-6;
s1 = sum(abs(dinfo1.im(:) - im(:)) > eps);
s2 = sum(abs(dinfo1.ii_im(:) - ii_im(:)) > eps);
if ((s1 == 0) && s2 == 0)
    disp('[Success] (Debug Point1): LoadIm is reliable');
else
    msg = '[Fail] (Debug Point1): LoadIm is not reliable';
    error(msg);
end
