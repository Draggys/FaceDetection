close all;
clear all;
clc;      

profile on

addpath('Data/TestImages/');
addpath('Data/TrainingImages/FACES/');


Tdata = load('training_data.mat');
Cparams = load('Cparams.mat');

%im = imread('Data/TestImages/one_chris.png');
%dets = ScanImageFixedSize(Cparams, im);
%DisplayDetections(im, dets);

%im2 = imread('Data/TestImages/big_one_chris.png');
im2 = imread('Data/TestImages/obama.jpg');
theta = 3;
theta = Cparams.thresh;
dets = ScanImageOverScale(Cparams, im2, 0.6, 1.3, 0.1, theta);
%dets = ScanImageOverScale(Cparams, im2, 0.02, 0.8, 0.05, theta);
DisplayDetections(im2, dets);

% profile viewer
% p = profile('info');
% profsave(p, 'profile_results');