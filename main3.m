close all;
clear all;
clc;

Tdata = load('training_data.mat');
Cparams = load('Cparams.mat');

[im, ii_ims] = LoadIm('face00001.bmp', 1);
score = ApplyDetector(Cparams, ii_ims);
if abs(score - 27669) > eps
   disp('[Success] ApplyDetector: Sanity Check'); 
else
   msg = ('[Fail] ApplyDetector: Sanity Check');
   error(msg);
end

thresh = ComputeROC(Cparams, Tdata);

% Add thresh to Cparams
alphas = Cparams.alphas;
Thetas = Cparams.Thetas;
fmat = Cparams.fmat;
all_ftypes = Cparams.all_ftypes;
save('Cparams', 'alphas', 'Thetas', 'fmat', 'all_ftypes', 'thresh');