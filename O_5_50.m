function O_5_50(Q)
for i=1:5
    Q=50;
    str='F:\graduation_project\YUV_to_image\';
    I=imread([str,num2str(i),'.jpg']); %���ζ�ȡÿһ��ͼ��
    I=double(I);
    u=16;
    v=16;
    w=18;
    z=22;
    fore=zeros(16,16);
    blocks_I=mat2cell(I,ones(w,1)*u,ones(z,1)*v);%��Ϊ16*16��СΪ18*22�Ŀ�
    for h=1:18
        forecast{h,1}=fore+128;
        residual{h,1}=blocks_I{h,1}-forecast{h,1};
        block_dct2=dct2(residual{h,1}); %DCT�任
        block_qua=round(block_dct2./Q); %������ȡ��������������
        Huffman_Code=Huffman_Coding_16x16(block_qua);
        block_iqua=Huffman_Code.*Q; %������
        block_idct2=idct2(block_iqua);%���任
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
    for a1=2:w
        cc=a1-1;
        for ww=1:16
            forecast{a1,1}(ww,:)=fore(ww,:)+row{cc,1};
        end
        for a4=2:18
            for a5=2:22
                residual{a1,1}=blocks_I{a1,1}-forecast{a1,1};
                [ PSNR,MSE ] = Psnr(blocks_I{a4,a5}(:),forecast{a4,a5}(:));
                MSE_O_16x16_5_50(a4,a5)=MSE;
            end
        end
        block=dct2(residual{a1,1}); %DCT�任
        block=round(block./Q); %������ȡ��������������
        block=block.*Q; %������
        block=idct2(block);%���任
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
                    fore(k,L)=blocks_I{a1,a2}(k,L-1)/2+blocks_I{a1,a2}(k-1,L)/2;%Ԥ��
                end
            end
            fore(:,1)=blocks_I{a1,bb}(:,16);%��1�е���m�еĵ�1��
            fore(1,:)=blocks_I{cc,a2}(16,:);%��1�е���n�еĵ�1��
            forecast{a1,a2}=fore;
            residual{a1,a2}=blocks_I{a1,a2}-forecast{a1,a2};%����в�
            
            
            block=dct2(residual{a1,a2}); %DCT�任
            block=round(block./Q); %������ȡ��������������
            block=block.*Q; %������
            block=idct2(block);%���任
            DCT_residual{a1,a2}=block;
            J=ones(16,16);
            J(:,1)=column{a1,bb}(:,1);%��1�е���m�еĵ�1��
            J(1,:)=row{cc,a2}(1,:);%��1�е���n�еĵ�1��
            
            for k=2:16
                for L=2:16
                    JJ =((J(k,L-1))/2+(J(k-1,L))/2);
                    J(k,L)=DCT_residual{a1,a2}(k,L)+JJ;%�ؽ����=���ֵ+Ԥ��ֵ
                end
            end
            blocks{a1,a2}=J;
            row{a1,a2}=blocks{a1,a2}(16,:);
            column{a1,a2}=blocks{a1,a2}(:,16);
            
            
        end
    end
    
    xlswrite('MSE_O_16x16_5_50.xls',MSE_O_16x16_5_50);
end
end