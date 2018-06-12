function [ PSNR,MSE ] = Psnr( im1,im2 )

%------------------------计算峰值信噪比程序———————————————-----
% im1 : the original image matrix
% im2 : the modified image matrix   

if (size(im1))~=(size(im2))
    error('错误：两个输入图象的大小不一致');
end

    [m,n] = size(im1);
    A = double(im1);
    B = double(im2);
    D = sum( sum( (A-B).^2 ) );%||A-B||^2
    MSE = D / (m * n);
if  D == 0
    error('两幅图像完全一样');
    PSNR = 200;
else
    PSNR = 10*log10( (255^2) / MSE );                                                        
end