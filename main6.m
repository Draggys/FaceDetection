close all;
clear all;
clc;

addpath('Data\TestImages\');

Tdata = load('training_data.mat');
Cparams = load('Cparams.mat');

dirname = 'Data\TestImages\';
images = dir([dirname '*']);
ims = [];
for i = 3 : size(images, 1)
    im = imread(images(i).name);
    theta = 3;
    dets = ScanImageOverScale(Cparams, im, 0.6, 1.3, 0.06, theta);
    DisplayDetections(im, dets);
    
    disp(['' num2str(i) '/' num2str(size(images,1))]);
end   

