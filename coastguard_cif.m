function coastguard_cif()
fid=fopen('F:\graduation_project\test_orde\coastguard_cif.yuv','rb');  
numfrm=5;%帧数
Y = cell(1,numfrm);  
U = cell(1,numfrm);  
V = cell(1,numfrm);   
for i=1:numfrm  
    Yd = fread(fid,[352 288],'uint8');  
    Y{i} = uint8(Yd)';     
    UVd = fread(fid,[352 288/4],'uint8');  
    U{i} = uint8(UVd)';  
    UVd = fread(fid,[352 288/4],'uint8');  
    V{i} = uint8(UVd)'; 
    figure(1),imshow(Y{i});
    strtemp=strcat('F:\graduation_project\YUV_to_image\',int2str(i),'.','jpg');
    imwrite(Y{i},strtemp,'jpg');%将每帧转成jpg的图片
end
end

