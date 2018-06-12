function proportion_mode_coastguard()
% clc;
% clear all;
% close all;
z = xlsread('F:\graduation_project\proportion_mode_coastguard.xls');
colormap(cool);% 控制图的用色
bar(z,'stack');%累计式直方图，例如:1,1+2,1+2+3构成了第一个bar
set(gca,'xticklabel',[]);
title('视频序列(coastguard)量化值从5到50时各种模式所占比例');
legend('横向预测','垂直预测','斜向预测');
end

