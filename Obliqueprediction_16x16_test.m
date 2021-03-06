% % close all;
clc;
% clear all;
for i=1:5
     Q=5;
    str='F:\graduation_project\YUV_to_image\'; 
    I=imread([str,num2str(i),'.jpg']); %依次读取每一幅图像
    I=double(I);
    u=16;
    v=16;
    w=18;
    z=22;
    fore=zeros(16,16);
%     foreq =fore()+128;
    blocks_I=mat2cell(I,ones(w,1)*u,ones(z,1)*v);%分为16*16大小为18*22的块
%     %% 
% % 当所有邻近的像素P(X，一1)、P(一1，y)X，y一1?15可得时 Pred(X，Y)=Clipl((a+b(x一7)+c(y一7)+16)>>5) (3．4)
% % 其中：
% % a=16(P(一1，15)+P(15，-1)) b=(5H+32)>>6
% % c=(5V+32)>>6 上式中的H和V有下式求得：
% % 8 H=∑x·(P(7+x，-1)-P(7-x，一1)) x=l
% % % 8 y=Zy·(P(-1，7+y)-P(-1，7一力
% for i=1:18
%     for j=1:22
% %         D=blocks_I{i,j};
%         for k=1:16
%         d=blocks_I{i,j}(k,1)+128;
%         end
%     end
% end
% for x=1:8
%     H=x*(blocks_I{1,:}(7+x,-1)-blocks_I{:,1}(7-x,-1));
% end
% for y=1:8
%     V=y*(blocks_I{1,1}(-1,7+y)-blocks_I{1,1}(-1,7-y));
% end
% a=16*(P(-1,15)+P(15,-1)); 
% b=(5*H+32)>6;
% c=(5*V+32)>6;
% Pred(x,y)=Clipl((a+b(x-7)+c(y-7)+16)>5);
% 
% 
% 
% 
% 
% 
% 
% 

    
for h=1:18
    forecast{h,1}=fore+128;
    residual{h,1}=blocks_I{h,1}-forecast{h,1};
    block_dct2=dct2(residual{h,1}); %DCT变换
    block_qua=round(block_dct2./Q); %量化，取整——四舍五入
    Huffman_Code=Huffman_Coding_16x16(block_qua);
    block_iqua=Huffman_Code.*Q; %反量化
%   block_iqua=block_qua.*Q; %反量化
    block_idct2=idct2(block_iqua);%反变换
    DCT_residual{h,1}=block_idct2;
    blocks{h,1}=DCT_residual{h,1}+forecast{h,1};
    row{h,1}=blocks{h,1}(16,:);
    column{h,1}=blocks{h,1}(:,16);
end
    
for a1=2:z
for a2=1:18
    cc=a1-1;
    for ww=1:16
    forecast{a2,a1}(:,ww)=fore(:,ww)+column{a2,cc};
    end
    residual{a2,a1}=blocks_I{a2,a1}-forecast{a2,a1};
    block=dct2(residual{a2,a1}); %DCT变换
    block=round(block./Q); %量化，取整——四舍五入
    block=Huffman_Coding_16x16(block)
    block=block.*Q; %反量化
    block=idct2(block);%反变换
    DCT_residual{a2,a1}=block;
    blocks{a2,a1}=DCT_residual{a2,a1}+forecast{a2,a1};
    row{a2,a1}=blocks{a2,a1}(16,:);
    column{a2,a1}=blocks{a2,a1}(:,16);
end
end
for a1=2:w
    cc=a1-1;
    for ww=1:16
    forecast{a1,1}(ww,:)=fore(ww,:)+row{cc,1};
    end
    residual{a1,1}=blocks_I{a1,1}-forecast{a1,1};
    block=dct2(residual{a1,1}); %DCT变换
    block=round(block./Q); %量化，取整——四舍五入
    block=block.*Q; %反量化
    block=idct2(block);%反变换 
    DCT_residual{a1,1}=block;
    blocks{a1,1}=DCT_residual{a1,1}+forecast{a1,1};
    row{a1,1}=blocks{a1,1}(16,:);
    column{a1,1}=blocks{a1,1}(:,16);
end
for a2=2:z
for a1=2:w
    cc=a1-1;
    bb=a2-1;
    for k=2:16
    for L=2:16
        fore(k,L)=blocks_I{a1,a2}(k,L-1)/2+blocks_I{a1,a2}(k-1,L)/2;%预测
    end
    end
    fore(:,1)=blocks_I{a1,bb}(:,16);%第1行到第m行的第1列
    fore(1,:)=blocks_I{cc,a2}(16,:);%第1列到第n列的第1行
    forecast{a1,a2}=fore;
    residual{a1,a2}=blocks_I{a1,a2}-forecast{a1,a2};%计算残差
    block=dct2(residual{a1,a2}); %DCT变换
    block=round(block./Q); %量化，取整——四舍五入
    block=block.*Q; %反量化
    block=idct2(block);%反变换
    DCT_residual{a1,a2}=block;
    J=ones(16,16);
    J(:,1)=column{a1,bb}(:,1);%第1行到第m行的第1列
    J(1,:)=row{cc,a2}(1,:);%第1列到第n列的第1行
    for k=2:16
    for L=2:16
        J(k,L)=DCT_residual{a1,a2}(k,L)+((J(k,L-1))/2+(J(k-1,L))/2);%重建输出=误差值+预测值
    end
    end
    blocks{a1,a2}=J;
    row{a1,a2}=blocks{a1,a2}(16,:);
    column{a1,a2}=blocks{a1,a2}(:,16);
end
end
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
% figure(1),imshow(W);title('复原残差图像');
% strtemp=strcat('F:\复原残差图片\',int2str(i),'.','jpg');
% imwrite(W,strtemp,'jpg');% 保存图片（以数字命名）
% figure(2),imshow(X);title('解码图像');
% strtemp=strcat('F:\解码图片\',int2str(i),'.','jpg');
% imwrite(X,strtemp,'jpg');% 保存图片（以数字命名）
% figure(3),imshow(Y);title('预测图像');
% strtemp=strcat('F:\预测图片\',int2str(i),'.','jpg');
% imwrite(Y,strtemp,'jpg');% 保存图片（以数字命名）
% figure(4),imshow(Z);title('残差图像');
% strtemp=strcat('F:\残差图片\',int2str(i),'.','jpg');
% imwrite(Z,strtemp,'jpg');% 保存图片（以数字命名）
end
% vv=tineyesearch_hist(X,I);
% snr1=SNR(I,j);
% [ PSNR1,MSE1 ] = Psnr(I,j);
% snr2=SNR(l,h);
% [ PSNR2,MSE2 ] = Psnr(l,h);
% % Modechange();
% % disp(['解码图像的信噪比是:',snr1,PSNR1,MSE1,snr2,PSNR2,MSE2]);
% Modechange();
% disp('16*16分块--斜向预测--复原残差图像--相关参数:')
% disp(['SNR:',num2str(snr2),'dB','     ','PSNR:',num2str(PSNR2),'dB','     ','MSE:',num2str(MSE2)]);
% disp('16*16分块--斜向预测--解码图像--相关参数:')
% disp(['SNR:',num2str(snr1),'dB','     ','PSNR:',num2str(PSNR1),'dB','     ','MSE:',num2str(MSE1)]);
