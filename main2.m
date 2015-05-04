close all;
clear all;
clc;

Tdata = load('training_data.mat');

% LearnWeakClassifier
fmat = Tdata.fmat;
ys = Tdata.ys;
ii_ims = Tdata.ii_ims;
fs = fmat(12028, :) * ii_ims;
ws = rand(1, size(fs, 2));
ws = ws / norm(ws, 1);
[ theta, p, err ] = LearnWeakClassifier( ws, fs, ys, Tdata.nrFaces );
% Sanity check
LearnWeakClassifierSanityCheck(Tdata);

% Display function I, weak classifier
fpic = MakeFeaturePic([4, 5, 5, 5, 5], 19, 19);
fig2 = figure;
colormap('gray');
imagesc(fpic);

% Display function II, strong classifier
cpic = MakeClassifierPic(Tdata.all_ftypes, [5192, 12765], [1.8725, 1.467], [1, -1], 19, 19);
fig3 = figure;
colormap('gray');
imagesc(cpic);