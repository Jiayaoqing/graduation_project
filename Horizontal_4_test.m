% function Horizontalprediction_4x4(Q)
% close all;
% clear all;
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
    for h=1:72
        forecast{h,1}=fore+128;
        residual{h,1}=blocks_I{h,1}-forecast{h,1};
        block_dct2=dct2(residual{h,1}); %DCT变换
        block_qua=round(block_dct2./Q); %量化，取整——四舍五入
        Huffman_Code=Huffman_Coding_4x4(block_qua);
        block_iqua=Huffman_Code.*Q; %反量化
        %   block_iqua=block_qua.*Q; %反量化
        block_idct2=idct2(block_iqua);%反变换
        DCT_residual{h,1}=block_idct2;
        blocks{h,1}=DCT_residual{h,1}+forecast{h,1};
        row{h,1}=blocks{h,1}(4,:);
        column{h,1}=blocks{h,1}(:,4);
    end
    for a1=2:z
        for a2=1:72
            cc=a1-1;
            for ww=1:4
                forecast{a2,a1}(:,ww)=fore(:,ww)+column{a2,cc};
            end
            residual{a2,a1}=blocks_I{a2,a1}-forecast{a2,a1};
            [ PSNR,MSE ] = Psnr(blocks_I{a2,a1}(:,ww),forecast{a2,a1}(:,ww));
            MSE_H_4x4(a2,a1)=MSE;
            block=dct2(residual{a2,a1}); %DCT变换
            block=round(block./Q); %量化，取整——四舍五入
            block=block.*Q; %反量化
            block=idct2(block);%反变换
            DCT_residual{a2,a1}=block;
            blocks{a2,a1}=DCT_residual{a2,a1}+forecast{a2,a1};
            row{a2,a1}=blocks{a2,a1}(4,:);
            column{a2,a1}=blocks{a2,a1}(:,4);
        end
    end
    xlswrite('MSE_H_4x4.xls',MSE_H_4x4);
    forecast_image=cell2mat(forecast);
    residual_image=cell2mat(residual);
    DCT_residual_image=cell2mat(DCT_residual);
    recover_image=cell2mat(blocks);
    i1=uint8(forecast_image);
    i2=uint8(residual_image);
    i3=uint8(DCT_residual_image);
    i4=uint8(recover_image);
    % snr1=SNR(I,j);
    % [ PSNR1,MSE1 ] = Psnr(I,j);
    % snr2=SNR(I,recover_image);
    % [ PSNR2,MSE2 ] = Psnr(I,recover_image);
    figure(1),imshow(i1);title('预测图像');
    strtemp=strcat('F:\graduation_project\forecast_image\',int2str(i),'.','jpg');
    imwrite(i1,strtemp,'jpg');% 保命名）存图片（以数字
    figure(2);subplot(1,2,1);imshow(i2);title('残差图像');
    strtemp=strcat('F:\graduation_project\residual_image\',int2str(i),'.','jpg');
    imwrite(i2,strtemp,'jpg');% 保存图片（以数字命名）
    subplot(1,2,2);imshow(i3);title('复原残差图像');
    strtemp=strcat('F:\graduation_project\recover_residual_image\',int2str(i),'.','jpg');
    imwrite(i3,strtemp,'jpg');% 保存图片（以数字命名）
    figure(3),imshow(i4);title('解码图像');
    strtemp=strcat('F:\graduation_project\decode_image\',int2str(i),'.','jpg');
    imwrite(i4,strtemp,'jpg');% 保存图片（以数字命名）
end


% end