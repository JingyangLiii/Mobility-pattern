%% ��������е����֮��ľ���

function [ dis ] = calDistance_single(x,y)
            %�����x�͵�y֮���ŷʽ����
            D=distance(x(1),x(2),y(1),y(2));
            pi=3.1415926;
            dx=D*6371*1000*2*pi/360;
            tmp=dx.^2+((x(3)-y(3))*0.3048).^2;%1 Ӣ��  = 0.3048 ��
            dis = sqrt(tmp);