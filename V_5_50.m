function V_5_50(Q)
for i=1:5
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
            [ PSNR,MSE ] = Psnr(blocks_I{aa,dd}(:,ww),forecast{aa,dd}(:,ww));
            MSE_V_16x16_5_50(aa,dd)=MSE;
            
            block=dct2(residual{aa,dd}); %DCT�任
            block=round(block./Q); %������ȡ��������������
            block=block.*Q; %������
            block=idct2(block);%���任
            DCT_residual{aa,dd}=block;
            blocks{aa,dd}=DCT_residual{aa,dd}+forecast{aa,dd};
            row{aa,dd}=blocks{aa,dd}(16,:);
            column{aa,dd}=blocks{aa,dd}(:,16);
            %      [ PSNR,MSE ] = Psnr(blocks_I{aa,dd}(:,ww),forecast{aa,dd}(:,ww));
            %  MSE_H_16x16(a4,a3)=MSE;
        end
    end
    xlswrite('MSE_V_16x16_5_50.xls',MSE_V_16x16_5_50);
    
end
end