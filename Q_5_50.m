clc;
clear all;
close all;
% for Q=5:50
%     H_5_50(Q);
%     V_5_50(Q);
%     O_5_50(Q);
%     [n1,n2,n3]=pie_16_chart_5_50();
%      proportion_mode((Q-4),:)=[n1,n2,n3];  
% %      xlswrite('proportion_mode.xls',proportion_mode);
% %     bar(y,0.2);
% %     clear all;
% end
% xlswrite('proportion_mode.xls',proportion_mode);
x = linspace(5,50,46);
% plot(x,[50]);
% Strain1_Mean = xlsread('F:\��ҵ���\proportion_mode.xls');
z = xlsread('F:\graduation_project\proportion_mode.xls');
% Strain1_Mean=[n1   n2    n3  ];
% Strain2_Mean=[0.4042    2.9884    0.5709  ];
% Strain1_std=[1.1393    2.8108    2.2203   ];
% Strain2_std=[0.8762    2.8478    0.9878   ];
% bar(x,[Strain1_Mean ]);
colormap(cool);% ����ͼ����ɫ
bar(z,'stack');%�ۼ�ʽֱ��ͼ������:1,1+2,1+2+3�����˵�һ��bar
set(gca,'xticklabel',5:50);
title('����ֵ��5��50ʱ����ģʽ��ռ����');
% bar3(z);%��ά�ķ���ʽֱ��ͼ
% title('3D default');
legend('����Ԥ��','��ֱԤ��','б��Ԥ��');
% pause; 

