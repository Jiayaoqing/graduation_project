function Verticalprediction_16x16(Q)
% close all;
% clear all;
for i=1:5
%     Q=5;
    str='F:\graduation_project\YUV_to_image\'; 
    I=imread([str,num2str(i),'.jpg']); %���ζ�ȡÿһ��ͼ��
    I=double(I);
    u=16;
    v=16;
    w=18;
    z=22;
    fore=zeros(16,16);
    blocks_I=mat2cell(I,ones(w,1)*u,ones(z,1)*v);%��Ϊ16*16��СΪ18*22�Ŀ�
for v=1:22
    forecast{1,v}=fore+128;
    residual{1,v}=blocks_I{1,v}-forecast{1,v};
    block_dct2=dct2(residual{1,v}); %DCT�任
    block_qua=round(block_dct2./Q); %������ȡ��������������
    Huffman_Code=Huffman_Coding_16x16(block_qua);
    block_iqua=Huffman_Code.*Q; %������
%     block_iqua=block_qua.*Q; %������
    block_idct2=idct2(block_iqua);%���任
    DCT_residual{1,v}=block_idct2;
    blocks{1,v}=DCT_residual{1,v}+forecast{1,v};
    row{1,v}=blocks{1,v}(16,:);
    column{1,v}=blocks{1,v}(:,16);
end
for aa=2:w
for dd=1:22
    cc=aa-1;
    for ww=1:16
    forecast{aa,dd}(ww,:)=fore(ww,:)+row{cc,dd};
    end
    residual{aa,dd}=blocks_I{aa,dd}-forecast{aa,dd};
    block=dct2(residual{aa,dd}); %DCT�任
    block=round(block./Q); %������ȡ��������������
    block=block.*Q; %������
    block=idct2(block);%���任 
    DCT_residual{aa,dd}=block;
    blocks{aa,dd}=DCT_residual{aa,dd}+forecast{aa,dd};
    row{aa,dd}=blocks{aa,dd}(16,:);
    column{aa,dd}=blocks{aa,dd}(:,16);
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
figure(1),imshow(W);title('��ԭ�в�ͼ��');
strtemp=strcat('F:\graduation_project\recover_residual_image\',int2str(i),'.','jpg');
imwrite(W,strtemp,'jpg');% ����ͼƬ��������������
figure(2),imshow(X);title('����ͼ��');
strtemp=strcat('F:\graduation_project\decode_image\',int2str(i),'.','jpg');
imwrite(X,strtemp,'jpg');% ����ͼƬ��������������
figure(3),imshow(Y);title('Ԥ��ͼ��');
strtemp=strcat('F:\graduation_project\forecast_image\',int2str(i),'.','jpg');
imwrite(Y,strtemp,'jpg');% ����ͼƬ��������������
figure(4),imshow(Z);title('�в�ͼ��');
strtemp=strcat('F:\graduation_project\residual_image\',int2str(i),'.','jpg');
imwrite(Z,strtemp,'jpg');% ����ͼƬ��������������
end
vv=tineyesearch_hist(X,I);
snr1=SNR(I,j);
[ PSNR1,MSE1 ] = Psnr(I,j);
snr2=SNR(l,h);
[ PSNR2,MSE2 ] = Psnr(l,h);
% Modechange();
% disp(['����ͼ����������:',snr1,PSNR1,MSE1,snr2,PSNR2,MSE2]);
[number1,ratio1]=symerr_pic(I,round(j));%%%%��������);
[number2,ratio2]=symerr_pic(Z,W);
% Modechange();
mode_selection();
disp('16*16�ֿ�--��ֱԤ��--��ԭ�в�ͼ��--��ز���:')
disp(['SNR:',num2str(snr2),'dB','     ','PSNR:',num2str(PSNR2),'dB','     ','MSE:',num2str(MSE2)]);
disp(['��������ֵ����:',num2str(number2),'     ','�����ʣ�ratio��:',num2str(ratio2)]);
disp('16*16�ֿ�--��ֱԤ��--����ͼ��--��ز���:')
disp(['SNR:',num2str(snr1),'dB','     ','PSNR:',num2str(PSNR1),'dB','     ','MSE:',num2str(MSE1)]);
disp(['��������ֵ����(number):',num2str(number1),'     ','������(ratio):',num2str(ratio1)]);


end