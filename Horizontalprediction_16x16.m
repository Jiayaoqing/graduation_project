function Horizontalprediction_16x16(Q)
for i=1:5         
    str='F:\graduation_project\YUV_to_image\';
    I=imread([str,num2str(i),'.jpg']); 
    I=double(I);
    u=16;
    v=16;
    w=18;
    z=22;
    fore=zeros(16,16);
    blocks_I=mat2cell(I,ones(w,1)*u,ones(z,1)*v);%��Ϊ16*16��СΪ18*22�Ŀ�
    for h=1:18                          %����Ԥ��
        forecast{h,1}=fore+128;
        residual{h,1}=blocks_I{h,1}-forecast{h,1};
        block_dct2=dct2(residual{h,1}); %DCT2�任
        block_qua=round(block_dct2./Q); %������ȡ��������������
        Huffman_Code=Huffman_Coding_16x16(block_qua);
        block_iqua=Huffman_Code.*Q;%������
        block_idct2=idct2(block_iqua);%DCT2���任
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
            block=dct2(residual{a2,a1}); %DCT�任
            block=round(block./Q); %������ȡ��������������
            block=block.*Q; %������
            block=idct2(block);%���任
            DCT_residual{a2,a1}=block;
            blocks{a2,a1}=DCT_residual{a2,a1}+forecast{a2,a1};
            row{a2,a1}=blocks{a2,a1}(16,:);
            column{a2,a1}=blocks{a2,a1}(:,16);
        end
    end
    forecast_image=cell2mat(forecast);
    residual_image=cell2mat(residual);
    DCT_residual_image=cell2mat(DCT_residual);
    recover_image=cell2mat(blocks);
    i1=uint8(forecast_image);
    i2=uint8(residual_image);
    i3=uint8(DCT_residual_image);
    i4=uint8(recover_image);
    figure(1),imshow(i1);title('Ԥ��ͼ��');
    strtemp=strcat('F:\graduation_project\forecast_image\',int2str(i),'.','jpg');
    imwrite(i1,strtemp,'jpg');% ����������ͼƬ��������
    % figure(2),imshow([i2,i3]);title(['�в�ͼ��','     ','��ԭ�в�ͼ��']);
    % strtemp=strcat('F:\graduation_project\�в�ͼ��\',int2str(i),'.','jpg');
    % imwrite(i2,strtemp,'jpg');% ����ͼƬ��������������
    % strtemp=strcat('F:\graduation_project\��ԭ�в�ͼ��\',int2str(i),'.','jpg');
    % imwrite(i3,strtemp,'jpg');% ����ͼƬ��������������
    % subplot(1,2,1);imshow(i2);title('�в�ͼ��');
    pic=cat(2,i2,i3);
    figure(2), imshow(pic);title('�в�ͼ���븴ԭ�в�ͼ��');
    strtemp=strcat('F:\graduation_project\residual_image\',int2str(i),'.','jpg');
    imwrite(i2,strtemp,'jpg');% ����ͼƬ��������������
    % subplot(1,2,2);imshow(i3);title('��ԭ�в�ͼ��');
    strtemp=strcat('F:\graduation_project\recover_residual_image\',int2str(i),'.','jpg');
    imwrite(i3,strtemp,'jpg');% ����ͼƬ��������������
    figure(3),imshow(i4);title('����ͼ��');
    strtemp=strcat('F:\graduation_project\decode_image\',int2str(i),'.','jpg');
    imwrite(i4,strtemp,'jpg');% ����ͼƬ��������������
end

vv=tineyesearch_hist(i4,I);
% dermabrasion();
snr1=SNR(I,recover_image);
[ PSNR1,MSE1 ] = Psnr(I,recover_image);
snr2=SNR(i2,i3);
[ PSNR2,MSE2 ] = Psnr(i2,i3);
% disp(['����ͼ����������:',snr1,PSNR1,MSE1,snr2,PSNR2,MSE2]);
% imhist(recover_image);
[number1,ratio1]=symerr_pic(I,round(recover_image));%%%%��������);
[number2,ratio2]=symerr_pic(i2,i3);
% Modechange();
mode_selection();
disp('16*16�ֿ�--ˮƽԤ��--��ԭ�в�ͼ��--��ز���:')
disp(['SNR:',num2str(snr2),'dB','     ','PSNR:',num2str(PSNR2),'dB','     ','MSE:',num2str(MSE2)]);
disp(['��������ֵ����:',num2str(number2),'     ','�����ʣ�ratio��:',num2str(ratio2)]);
disp('16*16�ֿ�--ˮƽԤ��--����ͼ��--��ز���:')
disp(['SNR:',num2str(snr1),'dB','     ','PSNR:',num2str(PSNR1),'dB','     ','MSE:',num2str(MSE1)]);
disp(['��������ֵ����(number):',num2str(number1),'     ','������(ratio):',num2str(ratio1)]);
end
