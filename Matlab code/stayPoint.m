clear all;
clc;
%x:原始数据集 y:将一组的停留点合并取平均之后的数据集 R:删去非停留点的数据集（1） F：只留下经纬度坐标和高度信息的数据集
data = load('../Sample data/coordinateData.txt'); % 导入数据集
D = 100; %距离上限(m)
T =150/24/3600; %时间下限(s)
[m,n] = size(data);%得到数据的大小
x = [(1:m)' data];%将得到的数据前一列加上序号
[m,n] = size(x);%重新计算数据集的大小 
x(:,6) = 0 ;%初始化停留点位置序号
number = 1;%停留点序号
i = 1;
% 对每一个点进行处理
while (i <= m)  %i从1到m
    for j= i+1:m
        dis=calDistance_single(x(i,2:4),x(j,2:4));
        if dis > D %两点之间距离超过上限
            if x(j-1,5)-x(i,5) < T %两点之间时间差没到下限
                i=i+1;
                break;
            else
                if x(j-1,5)-x(i,5) >= T %两点之间时间差达到下限
                    x(i:j-1,6) = number;
                    number=number+1;
                    i=j;
                    break;
                end
            end
        end
    end
    if (j==m)
        if x(j,5)-x(i,5) >= T %两点之间时间差达到下限
        x(i:j,6) = number;
        end
        break;
    end
end

%取停留点坐标平均值
i=1;
k=1;
while (i <= m)
    if x(i,6) ~= 0 %不等于0为停留点
        Latemp=0;
        Lotemp=0;
        Altemp=0;
        Ttemp=0;
        for j=i:m  %读取从i开始这一个停留点中所有数据
            Latemp=Latemp+x(j,2);
            Lotemp=Lotemp+x(j,3);
            Altemp=Altemp+x(j,4);
            Ttemp=Ttemp+x(j,5);
            if j==m  %读取到了数据最后一行
               y(k,:)=[k Latemp/(j-i+1) Lotemp/(j-i+1) Altemp/(j-i+1) Ttemp/(j-i+1) x(i,6)];%取平均，存入y
               i=j+1;  %循环结束
            else if x(j+1,6) ~= x(i,6) %读到新的停留点的开始或者途经点
                y(k,:)=[k Latemp/(j-i+1) Lotemp/(j-i+1) Altemp/(j-i+1) Ttemp/(j-i+1) x(i,6)];%取平均，存入y
                k=k+1;
                i=j+1;
                break;
                end
            end
        end
    else
        y(k,:)=x(i,:);%途经点
        k=k+1;
        i=i+1;
    end
end

[m,~] = size(y);
j=1;
for i=1:m
    if y(i,6)~=0
        R(j,:)=y(i,:);
        j=j+1;
    end
end

