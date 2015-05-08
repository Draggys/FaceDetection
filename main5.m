close all;
clear all;
clc;

% Run this instead of main2
% I.e new Cparams

Tdata = load('training_data.mat');
Cparams = BoostingAlg(Tdata, 100);

alphas = Cparams.alphas;
Thetas = Cparams.Thetas;
fmat = Cparams.fmat;
all_ftypes = Cparams.all_ftypes;
save('Cparams', 'alphas', 'Thetas', 'fmat', 'all_ftypes');
