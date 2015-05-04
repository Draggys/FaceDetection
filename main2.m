close all;
clear all;
clc;

Tdata = load('training_data.mat');

% lLearnWeakClassifier
fmat = Tdata.fmat;
ys = Tdata.ys;
ii_ims = Tdata.ii_ims;
fs = fmat(12028, :) * ii_ims;
ws = rand(1, size(fs, 2));
ws = ws / sum(ws);
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

% Boosting algorithm
% Sanity check
Cparams = BoostingAlg(Tdata, 3);
fs1 = Cparams.Thetas(1, 1);
fs2 = Cparams.Thetas(2, 1);
fs3 = Cparams.Thetas(3, 1);
fpic1 = MakeFeaturePic(Tdata.all_ftypes(fs1, :), 19, 19);
fpic2 = MakeFeaturePic(Tdata.all_ftypes(fs2, :), 19, 19);
fpic3 = MakeFeaturePic(Tdata.all_ftypes(fs3, :), 19, 19);

fig4 = figure;
colormap('gray');
imagesc(fpic1);

fig5 = figure;
colormap('gray');
imagesc(fpic2);

fig6 = figure;
colormap('gray');
imagesc(fpic3);

% dinfo6 = load('Data/DebugInfo/debuginfo6.mat');
% T = dinfo6.T;
% Cparams = BoostingAlg(Tdata, T);
% nrWrongAlphas = sum(abs(dinfo6.alphas - Cparams.alphas) > eps)
% nrWrongThetas = sum(abs(dinfo6.Thetas(:) - Cparams.Thetas(:)) > eps)

dinfo7 = load('Data\DebugInfo\debuginfo7.mat');
T = dinfo7.T;
Cparams = BoostingAlg(Tdata, T);
sum(abs(dinfo7.alphas - Cparams.alphas) > eps)
sum(abs(dinfo7.Thetas(:) - Cparams.Thetas(:)) > eps)