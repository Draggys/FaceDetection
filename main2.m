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

fpic = MakeFeaturePic([4, 5, 5, 5, 5], 19, 19);
fig2 = figure;
imagesc(fpic)