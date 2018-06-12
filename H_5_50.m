function H_5_50(Q)

for i=1:5          %֡����i����������i֡����
    str='F:\graduation_project\YUV_to_image\';
    I=imread([str,num2str(i),'.jpg']); %���ζ�ȡÿһ��ͼ��
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
    for a1=2:22
        for a2=1:18
            cc=a1-1;
            for ww=1:16
                forecast{a2,a1}(:,ww)=fore(:,ww)+column{a2,cc};
            end
            residual{a2,a1}=blocks_I{a2,a1}-forecast{a2,a1};
            [ PSNR,MSE ] = Psnr(blocks_I{a2,a1}(:,ww),forecast{a2,a1}(:,ww));
            MSE_H_16x16_5_50(a2,a1)=MSE;
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
    xlswrite('MSE_H_16x16_5_50.xls',MSE_H_16x16_5_50);
end
end
