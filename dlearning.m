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

 k=200;
 
 %initilize dictionary and alpha
 randX=randperm(size(X, 2));
 D=X(:, randX(1:k));
 alpha=zeros(k, size(X, 2));  

%Sparse Coding
iters=0;
while iters<15
    for j=1:size(X, 2)
        cvx_begin quiet
        variable A(k);
        minimize(.5*norm(D*A-X(:, j)));
        subject to;
        norm(A, 1) <= 10
        cvx_end
        alpha(:, j)=A;
    end 
    
    iters=iters+1;

    %Dictionary Learning
    D=X*pinv(alpha);
    D=D./repmat(sqrt(sum(D.^2)),[size(D, 1), 1]);

    cd('/home/mpcr/Desktop/butterflies-master/spams-matlab');
    start_spams;
    displayPatches(D); colormap('gray');
    pause;
end



