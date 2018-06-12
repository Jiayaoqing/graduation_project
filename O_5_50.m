function O_5_50(Q)
for i=1:5
    Q=50;
    str='F:\graduation_project\YUV_to_image\';
    I=imread([str,num2str(i),'.jpg']); %依次读取每一幅图像
    I=double(I);
    u=16;
    v=16;
    w=18;
    z=22;
    fore=zeros(16,16);
    blocks_I=mat2cell(I,ones(w,1)*u,ones(z,1)*v);%分为16*16大小为18*22的块
    for h=1:18
        forecast{h,1}=fore+128;
        residual{h,1}=blocks_I{h,1}-forecast{h,1};
        block_dct2=dct2(residual{h,1}); %DCT变换
        block_qua=round(block_dct2./Q); %量化，取整——四舍五入
        Huffman_Code=Huffman_Coding_16x16(block_qua);
        block_iqua=Huffman_Code.*Q; %反量化
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
        for a4=2:18
            for a5=2:22
                residual{a1,1}=blocks_I{a1,1}-forecast{a1,1};
                [ PSNR,MSE ] = Psnr(blocks_I{a4,a5}(:),forecast{a4,a5}(:));
                MSE_O_16x16_5_50(a4,a5)=MSE;
            end
        end
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
                    JJ =((J(k,L-1))/2+(J(k-1,L))/2);
                    J(k,L)=DCT_residual{a1,a2}(k,L)+JJ;%重建输出=误差值+预测值
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