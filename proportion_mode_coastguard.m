function proportion_mode_coastguard()
% clc;
% clear all;
% close all;
z = xlsread('F:\graduation_project\proportion_mode_coastguard.xls');
colormap(cool);% ����ͼ����ɫ
bar(z,'stack');%�ۼ�ʽֱ��ͼ������:1,1+2,1+2+3�����˵�һ��bar
set(gca,'xticklabel',[]);
title('��Ƶ����(coastguard)����ֵ��5��50ʱ����ģʽ��ռ����');
legend('����Ԥ��','��ֱԤ��','б��Ԥ��');
end

