function proportion_mode_bus()
% clc;
% clear all;
% close all;
z = xlsread('F:\graduation_project\proportion_mode_bus.xls');
colormap(cool);% ����ͼ����ɫ
bar(z,'stack');%�ۼ�ʽֱ��ͼ������:1,1+2,1+2+3�����˵�һ��bar
set(gca,'xticklabel',[]);
title('��Ƶ����(bus)����ֵ��5��50ʱ����ģʽ��ռ����');
legend('����Ԥ��','��ֱԤ��','б��Ԥ��');
end