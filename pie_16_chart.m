function pie_16_chart()
% clear all;
H = xlsread('F:\graduation_project\MSE_H_16x16.xls');
V = xlsread('F:\graduation_project\MSE_V_16x16.xls');
O = xlsread('F:\graduation_project\MSE_O_16x16.xls');
[min1]=min_AB(H,V);
[min]=min_AB(O,min1);
% position=zeros(18,22);
% flag1='mode_H';
% flag2='mode_V';
% flag3='mode_O';
for i=2:18
    for j=2:22
        if (H(i,j)==min(i,j))
            %             position1=[i,j];
            %             n=ismember(H,min);
            %             H(i,j)=str2double(flag1);
            H(i,j)=0;
            HH{i,j}='mode_H';
        end
        
        if (V(i,j)==min(i,j))
            %             position2=[i,j];
            %             V(i,j)=str2double(flag2);
            V(i,j)=0;
            VV{i,j}='mode_V';
        end
        
        if (O(i,j)==min(i,j))
            %             position3=[i,j];
            %             O(i,j)=str2double(flag3);
            O(i,j)=0;
            OO{i,j}='mode_O';
        end
    end
end
% final={HH VV OO};
% xlswrite('min_mse.xls',min);
% xlswrite('HH.xls',HH);
% xlswrite('VV.xls',VV);
% xlswrite('OO.xls',OO);

[i1,j1] = find(strcmp(HH, 'mode_H'));
mode_H_number=length(i1);
[i2,j2] = find(strcmp(VV, 'mode_V'));
mode_V_number=length(i2);
[i3,j3] = find(strcmp(OO, 'mode_O'));
mode_O_number=length(i3);
Mode_number_sum=mode_H_number+mode_V_number+mode_O_number;
Mode_number=[mode_H_number,mode_V_number,mode_O_number];
explode=[1,1,1];
n1=mode_H_number./Mode_number_sum;
n2=mode_V_number./Mode_number_sum;
n3=mode_O_number./Mode_number_sum;
labels={'横向预测','垂直预测','斜向预测'};
pie3(Mode_number,explode);
legend(labels);
end
% H1 = xlsread('F:\毕业设计\HH.xls','A1;V18');
% V1 = xlsread('F:\毕业设计\VV.xls','A1;V18');
% O1 = xlsread('F:\毕业设计\OO.xls','A1;V18');
% D=strcmp(OO,VV);
% [i,j] = find(strcmp(HH, 'mode_H'));
% [i,j] = find(strcmp(VV, 'mode_V'));
% [i,j] = find(strcmp(OO, 'mode_O'));
% 求data的最大最小值
% H=uint8(H);
% V=uint8(V);
% O=uint8(O);
% minX = min(H);
% maxX = max(H);
% minY = min(V);
% maxY = max(V);
% 
% % 画出一维平面
% [x1 , y1] = meshgrid(minX:0.01:maxX, minY:0.01:maxY);
% 
% % 散乱点插值
% z1 = griddata(H, V, O, x1, y1);
% 
% % 画平面
% surf(x1, y1, z1);
% hold on
% 
% % 平面上面再画点
% plot3(H, V, O, 'o','markersize',10);
% 
% xlabel('H');
% ylabel('V');
% zlabel('O');
% grid on;
% 
% figure;
% 
% % 等高线
% contourf(x1,y1,z1);
% ischar('HH{:}');
% if(HH{:}~='mode_H')
%     
%     HH{:}=0;
% end
% findstr(HH, 'mode_H');
% findstr(VV, 'mode_V');
% findstr(OO, 'mode_O');
%     % [m n]=size(H);
    % for i=2:m
    %     for j=2:n
    %         if(H(i,j)==0)
    %             HH{i,j}='mode_H';
    %         end
    %         if(V(i,j)==0)
    %             VV{i,j}='mode_V';
    %         end
    %         if(O(i,j)==0)
    %             OO{i,j}='mode_O';
    %         end
    %     end
    % end
    % final={HH VV OO};
    %
    
    
    
    
    
    
    
