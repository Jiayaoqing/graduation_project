function V_5_50(Q)
for i=1:5
    str='F:\graduation_project\YUV_to_image\';
    I=imread([str,num2str(i),'.jpg']); %依次读取每一幅图像
    I=double(I);
    u=16;
    v=16;
    w=18;
    z=22;
    fore=zeros(16,16);
    blocks_I=mat2cell(I,ones(w,1)*u,ones(z,1)*v);%分为16*16大小为18*22的块
    for v=1:22
        forecast{1,v}=fore+128;
        residual{1,v}=blocks_I{1,v}-forecast{1,v};
        block_dct2=dct2(residual{1,v}); %DCT变换
        block_qua=round(block_dct2./Q); %量化，取整——四舍五入
        Huffman_Code=Huffman_Coding_16x16(block_qua);
        block_iqua=Huffman_Code.*Q; %反量化
        block_idct2=idct2(block_iqua);%反变换
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
            
            block=dct2(residual{aa,dd}); %DCT变换
            block=round(block./Q); %量化，取整——四舍五入
            block=block.*Q; %反量化
            block=idct2(block);%反变换
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