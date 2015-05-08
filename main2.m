close all;
clear all;
clc;

eps = 1e-6;
Tdata = load('training_data.mat');

% lLearnWeakClassifier
fmat = Tdata.fmat;
ys = Tdata.ys;
ii_ims = Tdata.ii_ims;
fs = fmat(12028, :) * ii_ims;
%ws = rand(1, size(fs, 2));
ws = ones(1, size(fs, 2)) / size(fs, 2);
%ws = ws / sum(ws);
[ theta, p, err ] = LearnWeakClassifier( ws, fs, ys, sum(ys==1));
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
% 
% % Boosting algorithm
% % Sanity check
% test to only ujse 1000 first fmat stuff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% only the first 1000 for debugging purposes
%Tdata.fmat = fmat(1:1000, :);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Cparams = BoostingAlg(Tdata, 3);
% fs1 = Cparams.Thetas(1, 1);
% fs2 = Cparams.Thetas(2, 1);
% fs3 = Cparams.Thetas(3, 1);
% fpic1 = MakeFeaturePic(Tdata.all_ftypes(fs1, :), 19, 19);
% fpic2 = MakeFeaturePic(Tdata.all_ftypes(fs2, :), 19, 19);
% fpic3 = MakeFeaturePic(Tdata.all_ftypes(fs3, :), 19, 19);
% 
% fig4 = figure;
% colormap('gray');
% imagesc(fpic1);
% 
% fig5 = figure;
% colormap('gray');
% imagesc(fpic2);
% 
% fig6 = figure;
% colormap('gray');
% imagesc(fpic3);
% 
% cpic = MakeClassifierPic(Tdata.all_ftypes, Cparams.Thetas(:, 1)', Cparams.alphas', Cparams.Thetas(:, 3)', 19, 19);
% fig5 = figure;
% colormap('gray');
% imagesc(cpic)

% DINFO6 START
% dinfo6 = load('Data/DebugInfo/debuginfo6.mat');
% T = dinfo6.T;
% Cparams = BoostingAlg(Tdata, T);
% nrWrongAlphas = sum(abs(dinfo6.alphas - Cparams.alphas) > eps);
% nrWrongThetas = sum(abs(dinfo6.Thetas(:) - Cparams.Thetas(:)) > eps);
% if nrWrongAlphas > 0|| nrWrongThetas > 0
%    msg = ('[Fail] BoostingAlg: Debug Point dinfo6')
%    error = msg;
% else
%    disp('[Success] BoostingAlg: Debug Point dinfo6'); 
% end


%%%%%%%%%
% Remeber to loop through all, not only the 1000
%%%%%%%%%
disp('dinfo7')
dinfo7 = load('Data\DebugInfo\debuginfo7.mat');
T = dinfo7.T;
Cparams = BoostingAlg(Tdata, T);
nrWrongAlphas = sum(abs(dinfo7.alphas - Cparams.alphas) > eps)
nrWrongThetas = sum(abs(dinfo7.Thetas(:) - Cparams.Thetas(:)) > eps)
if nrWrongAlphas > 0|| nrWrongThetas > 0
   msg = ('[Fail] BoostingAlg: Debug Point dinfo7')
   error = msg;
else
   disp('[Success] BoostingAlg: Debug Point dinfo7'); 
end

alphas = Cparams.alphas;
Thetas = Cparams.Thetas;
fmat = Cparams.fmat;
all_ftypes = Cparams.all_ftypes;
%save('Cparams', 'alphas', 'Thetas', 'fmat', 'all_ftypes');


Tdata.fmat = fmat(1:1000, :);
fs1 = Cparams.Thetas(1, 1);
fs2 = Cparams.Thetas(2, 1);
fs3 = Cparams.Thetas(3, 1);
fs4 = Cparams.Thetas(4, 1);
fs5 = Cparams.Thetas(5, 1);
fs6 = Cparams.Thetas(6, 1);
fs7 = Cparams.Thetas(7, 1);
fs8 = Cparams.Thetas(8, 1);
fs9 = Cparams.Thetas(9, 1);
fs10 = Cparams.Thetas(10, 1);

fpic1 = MakeFeaturePic(Tdata.all_ftypes(fs1, :), 19, 19);
fpic2 = MakeFeaturePic(Tdata.all_ftypes(fs2, :), 19, 19);
fpic3 = MakeFeaturePic(Tdata.all_ftypes(fs3, :), 19, 19);
fpic4 = MakeFeaturePic(Tdata.all_ftypes(fs4, :), 19, 19);
fpic5 = MakeFeaturePic(Tdata.all_ftypes(fs5, :), 19, 19);
fpic6 = MakeFeaturePic(Tdata.all_ftypes(fs6, :), 19, 19);
fpic7 = MakeFeaturePic(Tdata.all_ftypes(fs7, :), 19, 19);
fpic8 = MakeFeaturePic(Tdata.all_ftypes(fs8, :), 19, 19);
fpic9 = MakeFeaturePic(Tdata.all_ftypes(fs9, :), 19, 19);
fpic10 = MakeFeaturePic(Tdata.all_ftypes(fs10, :), 19, 19);

fig7 = figure;
colormap('gray');
imagesc(fpic1);

fig8 = figure;
colormap('gray');
imagesc(fpic2);

fig9 = figure;
colormap('gray');
imagesc(fpic3);
fig10 = figure;
colormap('gray');
imagesc(fpic4);
fig11 = figure;
colormap('gray');
imagesc(fpic5);
fig12 = figure;
colormap('gray');
imagesc(fpic6);
fig13 = figure;
colormap('gray');
imagesc(fpic7);
fig14 = figure;
colormap('gray');
imagesc(fpic8);
fig15 = figure;
colormap('gray');
imagesc(fpic9);
fig16 = figure;
colormap('gray');
imagesc(fpic10);


cpic = MakeClassifierPic(Tdata.all_ftypes, Cparams.Thetas(:, 1)', Cparams.alphas', Cparams.Thetas(:, 3)', 19, 19);
fig11 = figure;
colormap('gray');
imagesc(cpic)