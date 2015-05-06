close all;
clear all;
clc;

addpath('Data\TrainingImages\FACES\');
addpath('Data\TrainingImages\NFACES\');

% Debug Point 1
[im, ii_im] = LoadIm('face00001.bmp', 1);

fig2 = figure;
colormap('gray');
imagesc(im);
fig2 = figure;
colormap('gray');
imagesc(ii_im);

dinfo1 = load('Data\DebugInfo\debuginfo1.mat');
eps = 1e-6;
s1 = sum(abs(dinfo1.im(:) - im(:)) > eps);
s2 = sum(abs(dinfo1.ii_im(:) - ii_im(:)) > eps);
if ((s1 == 0) && s2 == 0)
    disp('[Success] (Debug Point1): LoadIm is reliable');
else
    s1
    s2
    msg = '[Fail] (Debug Point1): LoadIm is not reliable';
    error(msg);
end

% Debug Point 2
VecBoxSumSanityCheck(im, ii_im);

% Debug Point 3
%Sanity check
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
if ~(a == b && b == c && c == d) && a == 0
    msg = '[Fail] (Debug Point3): VecFeature is not reliable';
    error(msg);
end
disp('[Success] (Debug Point3): VecFeature is reliable');

% Enumerate all features
all_ftypes = EnumAllFeatures(W, H);
% Sanity check
if size(all_ftypes, 1) ~= 32746
    msg = '[Fail] EnumAllFeatures: Failed sanity check';
    error(msg);
end

% Debug Point 4
dinfo3 = load('Data\DebugInfo\debuginfo3.mat');
fmat = VecAllFeatures(dinfo3.all_ftypes, W, H);
anyOver0 = sum(abs(dinfo3.fs - fmat * ii_im(:)) > eps);
if anyOver0 == 0
    disp('[Success] (Debug Point4): VecAllFeatures is reliable');
else
    msg = '[Fail] (Debug Point 4): VecAllFeatures is not reliable';
    error(msg);
end

% Extract features and training data
face_fnames = dir('Data\FACES\*.bmp');

% Debug Point 5
dinfo4 = load('Data\DebugInfo\debuginfo4.mat');
%ni = dinfo4.ni; % does not contain ni
ni = 100;
ii_ims = LoadImDataDir('Data\TrainingImages\FACES\', ni);
fmat = VecAllFeatures(dinfo4.all_ftypes, 19, 19);

if sum(abs(dinfo4.fmat(:) - fmat(:))) > eps
    msg = '[Fail] (Debug Point 5): VecAllFeatures is not reliable';
    error(msg);
else
    disp('[Success] (Debug Point5): VecAllFeatures is reliable');
end

if sum(abs(dinfo4.ii_ims - ii_ims)) > eps
    msg = '[Fail] (Debug Point 5): LoadImDataDir is not reliable for ii_ims';
    error(msg);
else
    disp('[Success] (Debug Point5): LoadImDataDir is reliable for ii_ims');
end

if sum(abs(dinfo4.fs - (fmat * ii_ims))) > eps 
    msg = '[Fail] (Debug Point 5): LoadImDataDir is not reliable for fs == fmat * ii_ims';
    error(msg);
else
    disp('[Success] (Debug Point5): LoadImDataDir is reliable for fs == fmat * ii_ims');
end

% Create the data required for training the face detector
dinfo5 = load('Data\DebugInfo\debuginfo5.mat');
train_inds = dinfo5.train_inds;
all_ftypes = dinfo5.all_ftypes;
SaveTrainingData(all_ftypes, train_inds, 'training_data.mat');

disp('-');
disp('From now on you can load your saved file into Matlab with the following command:')
disp('Tdata = load(''training_data.mat'')');




