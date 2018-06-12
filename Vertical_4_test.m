% function Verticalprediction_4x4(Q)
close all;
clear all;
for i=1:5
    Q=5;
    str='F:\graduation_project\YUV_to_image\'; 
    I=imread([str,num2str(i),'.jpg']); %依次读取每一幅图像
    I=double(I);
    u=4;
    v=4;
    w=72;
    z=88;
    fore=zeros(4,4);
    blocks_I=mat2cell(I,ones(w,1)*u,ones(z,1)*v);%分为4*4大小为72*88的块
for v=1:88
    forecast{1,v}=fore+128;
    residual{1,v}=blocks_I{1,v}-forecast{1,v};
    block_dct2=dct2(residual{1,v}); %DCT变换
    block_qua=round(block_dct2./Q); %量化，取整——四舍五入 Huffman_Code=Huffman_Coding(block_qua);
    Huffman_Code=Huffman_Coding_4x4(block_qua);
    block_iqua=Huffman_Code.*Q; %反量化
%     block_iqua=block_qua.*Q; %反量化
    block_idct2=idct2(block_iqua);%反变换
    DCT_residual{1,v}=block_idct2;
    blocks{1,v}=DCT_residual{1,v}+forecast{1,v};
    row{1,v}=blocks{1,v}(4,:);
    column{1,v}=blocks{1,v}(:,4);
end
for aa=2:w
for dd=1:88
    cc=aa-1;
    for ww=1:4
    forecast{aa,dd}(ww,:)=fore(ww,:)+row{cc,dd};
    end
    residual{aa,dd}=blocks_I{aa,dd}-forecast{aa,dd};
    [ PSNR,MSE ] = Psnr(blocks_I{aa,dd}(ww,:),forecast{aa,dd}(ww,:));
    MSE_V_16x16(aa,dd)=MSE; 
    block=dct2(residual{aa,dd}); %DCT变换
    block=round(block./Q); %量化，取整——四舍五入
    block=block.*Q; %反量化
    block=idct2(block);%反变换 
    DCT_residual{aa,dd}=block;
    blocks{aa,dd}=DCT_residual{aa,dd}+forecast{aa,dd};
    row{aa,dd}=blocks{aa,dd}(4,:);
    column{aa,dd}=blocks{aa,dd}(:,4);
end
end
xlswrite('MSE_V_4x4.xls',MSE_V_4x4);
h=cell2mat(DCT_residual);
j=cell2mat(blocks); 
k=cell2mat(forecast);
l=cell2mat(residual);
W=uint8(h);
Y=uint8(k);
Z=uint8(l);
X=uint8(j);
snr=SNR(I,j);
[ PSNR,MSE ] = Psnr( I,j );
snr1=SNR(I,j);
snr1=SNR(I,j);
figure(1),imshow(W);title('复原残差图像');
strtemp=strcat('F:\graduation_project\recover_residual_image\',int2str(i),'.','jpg');
imwrite(W,strtemp,'jpg');% 保存图片（以数字命名）
figure(2),imshow(X);title('解码图像');
strtemp=strcat('F:\graduation_project\decode_image\',int2str(i),'.','jpg');
imwrite(X,strtemp,'jpg');% 保存图片（以数字命名）
figure(3),imshow(Y);title('预测图像');
strtemp=strcat('F:\graduation_project\forecast_image\',int2str(i),'.','jpg');
imwrite(Y,strtemp,'jpg');% 保存图片（以数字命名）
figure(4),imshow(Z);title('残差图像');
strtemp=strcat('F:\graduation_project\residual_image\',int2str(i),'.','jpg');
imwrite(Z,strtemp,'jpg');% 保存图片（以数字命名）
end
vv=tineyesearch_hist(X,I);
snr1=SNR(I,j);
[ PSNR1,MSE1 ] = Psnr(I,j);
snr2=SNR(l,h);
[ PSNR2,MSE2 ] = Psnr(l,h);
% Modechange();
% disp(['解码图像的信噪比是:',snr1,PSNR1,MSE1,snr2,PSNR2,MSE2]);
[number1,ratio1]=symerr_pic(I,round(j));%%%%四舍五入);
[number2,ratio2]=symerr_pic(Z,W);
% Modechange();
mode_selection();
disp('4*4分块--垂直预测--复原残差图像--相关参数:')
disp(['SNR:',num2str(snr2),'dB','     ','PSNR:',num2str(PSNR2),'dB','     ','MSE:',num2str(MSE2)]);
disp(['错误像素值个数:',num2str(number2),'     ','误码率（ratio）:',num2str(ratio2)]);
disp('4*4分块--垂直预测--解码图像--相关参数:')
disp(['SNR:',num2str(snr1),'dB','     ','PSNR:',num2str(PSNR1),'dB','     ','MSE:',num2str(MSE1)]);
disp(['错误像素值个数(number):',num2str(number1),'     ','误码率(ratio):',num2str(ratio1)]);

% end