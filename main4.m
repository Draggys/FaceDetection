close all;
clear all;
clc;      

addpath('Data\TestImages\');
addpath('Data\TrainingImages\FACES\');


Tdata = load('training_data.mat');
Cparams = load('Cparams.mat');

im = imread('Data\TestImages\one_chris.png');
dets = ScanImageFixedSize(Cparams, im);
DisplayDetections(im, dets);

im2 = imread('Data\TestImages\big_one_chris.png');
theta = 3;
dets = ScanImageOverScale(Cparams, im2, 0.6, 1.3, 0.06, theta);
DisplayDetections(im2, dets);