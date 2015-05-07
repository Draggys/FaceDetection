close all;
clear all;
clc;      

addpath('Data\TestImages\');
addpath('Data\TrainingImages\FACES\');


Tdata = load('training_data.mat');
Cparams = load('Cparams.mat');
% 
% [im, ii_im] = LoadIm('Data\TestImages\big_one_chris.png', 1);
% ScanImageFixedSize(Cparams, ii_im);

%im = imread('Data\TrainingImages\FACES\face00001.bmp');
im = imread('Data\TestImages\many_faces.jpg');
dets = ScanImageFixedSize(Cparams, im)