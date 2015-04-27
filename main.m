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

% Debug Point 2
VecBoxSumSanityCheck(im, ii_im);

% Debug Point 3
% Sanity check
VecFeatureSanityCheck(im, ii_im, 1)
VecFeatureSanityCheck(im, ii_im, 2)
VecFeatureSanityCheck(im, ii_im, 3)
VecFeatureSanityCheck(im, ii_im, 4)
 % Debug point check
dinfo2 = load('Data\DebugInfo\debuginfo2.mat');
fs = dinfo2.fs;
W = 19;
H = 19;
a = abs(fs(1) - VecFeature(dinfo2.ftypes(1, :), W, H) * ii_im(:)) < eps;
b = abs(fs(2) - VecFeature(dinfo2.ftypes(2, :), W, H) * ii_im(:)) < eps;
c = abs(fs(3) - VecFeature(dinfo2.ftypes(3, :), W, H) * ii_im(:)) < eps;
d = abs(fs(4) - VecFeature(dinfo2.ftypes(4, :), W, H) * ii_im(:)) < eps;
if ~(a == b && b == c && c == d)
    msg = '[Fail] (Debug Point3): VecFeature is not reliable';
    error(msg);
end
disp('[Success] (Debug Point3): VecFeature is reliable');