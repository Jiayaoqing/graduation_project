function proportion_mode_flower()
% clc;
% clear all;
% close all;
z = xlsread('F:\graduation_project\proportion_mode_flower.xls');
colormap(cool);% ����ͼ����ɫ
bar(z,'stack');%�ۼ�ʽֱ��ͼ������:1,1+2,1+2+3�����˵�һ��bar
set(gca,'xticklabel',[]);
title('��Ƶ����(flower)����ֵ��5��50ʱ����ģʽ��ռ����');
legend('����Ԥ��','��ֱԤ��','б��Ԥ��');
end