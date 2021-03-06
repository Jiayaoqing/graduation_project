% 手动调节量化值Q的值，需要先选择YUV_test函数，然后在文件夹中生成图像，这样才可以使用Q值进行操作。
% 先注释下，程序运行很快，到写入表格之前就好。
% 将proportion_mode_x换成之前YUV_test的序列，不同的序列对应不同的并转图！
clc;
clear all;
close all;
for Q=5:15
    H_5_50(Q);
    V_5_50(Q);
    O_5_50(Q);
    [n1,n2,n3]=pie_16_chart_5_50();
    proportion_mode_x((Q-4),:)=[n1,n2,n3];
    %     xlswrite('proportion_mode.xls',proportion_mode);
    %     bar(y,0.2);
    %     clear all;
end
xlswrite('proportion_mode_x.xls',proportion_mode_x);
% x = linspace(5,50,46);
% plot(x,[50]);
% Strain1_Mean = xlsread('F:\毕业设计\proportion_mode.xls');
z = xlsread('F:\graduation_project\proportion_mode_x.xls');
% Strain1_Mean=[n1   n2    n3  ];
% Strain2_Mean=[0.4042    2.9884    0.5709  ];
% Strain1_std=[1.1393    2.8108    2.2203   ];
% Strain2_std=[0.8762    2.8478    0.9878   ];
% bar(x,[Strain1_Mean ]);
colormap(cool);% 控制图的用色
bar(z,'stack');%累计式直方图，例如:1,1+2,1+2+3构成了第一个bar
set(gca,'xticklabel',5:50);
title('量化值从5到50时各种模式所占比例');
% bar3(z);%三维的分组式直方图
% title('3D default');
legend('横向预测','垂直预测','斜向预测');
% pause;

