function Obliqueprediction_4x4(Q)
% close all;
% clear all;
for i=1:5
%     Q=5;
    str='F:\graduation_project\YUV_to_image\'; 
    I=imread([str,num2str(i),'.jpg']); %���ζ�ȡÿһ��ͼ��
    I=double(I);
    u=4;
    v=4;
    w=72;
    z=88;
    fore=zeros(4,4);
    blocks_I=mat2cell(I,ones(w,1)*u,ones(z,1)*v);%��Ϊ16*16��СΪ18*22�Ŀ�
    forecast{1,1}=fore+128;
    residual{1,1}=blocks_I{1,1}-forecast{1,1};
    block_dct2=dct2(residual{1,1}); %DCT�任
    block_qua=round(block_dct2./Q); %������ȡ��������������
    Huffman_Code=Huffman_Coding_4x4(block_qua);
    block_iqua=Huffman_Code.*Q; %������
%   block_iqua=block_qua.*Q; %������
    block_idct2=idct2(block_iqua);%���任
    DCT_residual{1,1}=block_idct2;
    blocks{1,1}=DCT_residual{1,1}+forecast{1,1};
    row{1,1}=blocks{1,1}(4,:);
    column{1,1}=blocks{1,1}(:,4); 
for aa=2:z
    cc=aa-1;
    for ww=1:4
    forecast{1,aa}(:,ww)=fore(:,ww)+column{1,cc};
    end
    residual{1,aa}=blocks_I{1,aa}-forecast{1,aa};
    block=dct2(residual{1,aa}); %DCT�任
    block=round(block./Q); %������ȡ��������������
    block=block.*Q; %������
    block=idct2(block);%���任
    DCT_residual{1,aa}=block;
    blocks{1,aa}=DCT_residual{1,aa}+forecast{1,aa};
    row{1,aa}=blocks{1,aa}(4,:);
    column{1,aa}=blocks{1,aa}(:,4);
end
for aa=2:w
    cc=aa-1;
    for ww=1:4
    forecast{aa,1}(ww,:)=fore(ww,:)+row{cc,1};
    end
    residual{aa,1}=blocks_I{aa,1}-forecast{aa,1};
    block=dct2(residual{aa,1}); %DCT�任
    block=round(block./Q); %������ȡ��������������
    block=block.*Q; %������
    block=idct2(block);%���任 
    DCT_residual{aa,1}=block;
    blocks{aa,1}=DCT_residual{aa,1}+forecast{aa,1};
    row{aa,1}=blocks{aa,1}(4,:);
    column{aa,1}=blocks{aa,1}(:,4);
end
for dd=2:z
for aa=2:w
    cc=aa-1;
    bb=dd-1;
    for k=2:4
    for L=2:4
        fore(k,L)=blocks_I{aa,dd}(k,L-1)/2+blocks_I{aa,dd}(k-1,L)/2;%Ԥ��
    end
    end
    fore(:,1)=blocks_I{aa,bb}(:,4);%��1�е���m�еĵ�1��
    fore(1,:)=blocks_I{cc,dd}(4,:);%��1�е���n�еĵ�1��
    forecast{aa,dd}=fore;
    residual{aa,dd}=blocks_I{aa,dd}-forecast{aa,dd};%����в�
    block=dct2(residual{aa,dd}); %DCT�任
    block=round(block./Q); %������ȡ��������������
    block=block.*Q; %������
    block=idct2(block);%���任
    DCT_residual{aa,dd}=block;
    J=ones(4,4);
    J(:,1)=column{aa,bb}(:,1);%��1�е���m�еĵ�1��
    J(1,:)=row{cc,dd}(1,:);%��1�е���n�еĵ�1��
    for k=2:4
    for L=2:4
        J(k,L)=DCT_residual{aa,dd}(k,L)+((J(k,L-1))/2+(J(k-1,L))/2);%�ؽ����=���ֵ+Ԥ��ֵ
    end
    end
    blocks{aa,dd}=J;
    row{aa,dd}=blocks{aa,dd}(4,:);
    column{aa,dd}=blocks{aa,dd}(:,4);
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
disp('4*4�ֿ�--б��Ԥ��--��ԭ�в�ͼ��--��ز���:')
disp(['SNR:',num2str(snr2),'dB','     ','PSNR:',num2str(PSNR2),'dB','     ','MSE:',num2str(MSE2)]);
disp(['��������ֵ����:',num2str(number2),'     ','�����ʣ�ratio��:',num2str(ratio2)]);
disp('4*4�ֿ�--б��Ԥ��--����ͼ��--��ز���::')
disp(['SNR:',num2str(snr1),'dB','     ','PSNR:',num2str(PSNR1),'dB','     ','MSE:',num2str(MSE1)]);
disp(['��������ֵ����(number):',num2str(number1),'     ','������(ratio):',num2str(ratio1)]);

end