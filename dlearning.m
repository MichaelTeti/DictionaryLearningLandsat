%Dictionary Learning Sparse Coding
%Michael A. Teti
%FAU Machine Perception and Cognitive Robotics Lab
%Version 1

%==========================================================================
%==========================================================================

clear all; 
close all;
clc;
dbstop if error;

%Load image
im=imread('guinea.jpg');
im=im2double(rgb2gray(im));
im=imresize(im, [1000 1000]);
X=im2col(im, [8 8], 'sliding'); %take 8x8 patches from image
randX=randperm(size(X, 2));
X=X(:, randX(1:100));  

%Feature Scaling
mu=mean(X);
sigma=std(X);
for j=1:size(X, 2);
    X(:, j)=(X(:, j)-mu(j))./sigma(j);
end



