function [n1,n2,n3]=pie_16_chart_5_50()
% clear all;
H = xlsread('F:\graduation_project\MSE_H_16x16_5_50.xls');
V = xlsread('F:\graduation_project\MSE_V_16x16_5_50.xls');
O = xlsread('F:\graduation_project\MSE_O_16x16_5_50.xls');
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
            HH_5_50{i,j}='mode_H';
        end
        
        if (V(i,j)==min(i,j))
            %             position2=[i,j];
            %             V(i,j)=str2double(flag2);
            V(i,j)=0;
            VV_5_50{i,j}='mode_V';
        end
        
        if (O(i,j)==min(i,j))
            %             position3=[i,j];
            %             O(i,j)=str2double(flag3);
            O(i,j)=0;
            OO_5_50{i,j}='mode_O';
        end
    end
end
[i1,j1] = find(strcmp(HH_5_50, 'mode_H'));
mode_H_number=length(i1);
[i2,j2] = find(strcmp(VV_5_50, 'mode_V'));
mode_V_number=length(i2);
[i3,j3] = find(strcmp(OO_5_50, 'mode_O'));
mode_O_number=length(i3);
Mode_number_sum=mode_H_number+mode_V_number+mode_O_number;
Mode_number=[mode_H_number,mode_V_number,mode_O_number];
explode=[1,1,1];
n1=mode_H_number./Mode_number_sum;
n2=mode_V_number./Mode_number_sum;
n3=mode_O_number./Mode_number_sum;
labels={'∫·œÚ‘§≤‚','¥π÷±‘§≤‚','–±œÚ‘§≤‚'};
pie3(Mode_number,explode);
legend(labels);
% y=[n1,n2,n3];
% bar(y,0.2); 
end
    
    
    
    
    
    
