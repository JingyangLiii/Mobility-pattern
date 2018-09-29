%% 计算矩阵中点与点之间的距离

function [ dis ] = calDistance_single(x,y)
            %计算点x和点y之间的欧式距离
            D=distance(x(1),x(2),y(1),y(2));
            pi=3.1415926;
            dx=D*6371*1000*2*pi/360;
            tmp=dx.^2+((x(3)-y(3))*0.3048).^2;%1 英尺  = 0.3048 米
            dis = sqrt(tmp);