close all;
clear all;
clc;

Tdata = load('training_data.mat');

% LearnWeakClassifier Sanity Check
LearnWeakClassifierSanityCheck(Tdata);