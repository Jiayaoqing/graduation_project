function proportion_mode_foreman()
% clc;
% clear all;
% close all;
z = xlsread('F:\graduation_project\proportion_mode_foreman.xls');
colormap(cool);% ����ͼ����ɫ
% figure(1);
bar(z,'stack');%�ۼ�ʽֱ��ͼ������:1,1+2,1+2+3�����˵�һ��bar
set(gca,'xticklabel',[]);
title('��Ƶ����(foreman)����ֵ��5��50ʱ����ģʽ��ռ����');
legend('����Ԥ��','��ֱԤ��','б��Ԥ��');
end