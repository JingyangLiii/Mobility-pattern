clear all;
clc;
%x:ԭʼ���ݼ� y:��һ���ͣ����ϲ�ȡƽ��֮������ݼ� R:ɾȥ��ͣ��������ݼ���1�� F��ֻ���¾�γ������͸߶���Ϣ�����ݼ�
data = load('../Sample data/coordinateData.txt'); % �������ݼ�
D = 100; %��������(m)
T =150/24/3600; %ʱ������(s)
[m,n] = size(data);%�õ����ݵĴ�С
x = [(1:m)' data];%���õ�������ǰһ�м������
[m,n] = size(x);%���¼������ݼ��Ĵ�С 
x(:,6) = 0 ;%��ʼ��ͣ����λ�����
number = 1;%ͣ�������
i = 1;
% ��ÿһ������д���
while (i <= m)  %i��1��m
    for j= i+1:m
        dis=calDistance_single(x(i,2:4),x(j,2:4));
        if dis > D %����֮����볬������
            if x(j-1,5)-x(i,5) < T %����֮��ʱ���û������
                i=i+1;
                break;
            else
                if x(j-1,5)-x(i,5) >= T %����֮��ʱ���ﵽ����
                    x(i:j-1,6) = number;
                    number=number+1;
                    i=j;
                    break;
                end
            end
        end
    end
    if (j==m)
        if x(j,5)-x(i,5) >= T %����֮��ʱ���ﵽ����
        x(i:j,6) = number;
        end
        break;
    end
end

%ȡͣ��������ƽ��ֵ
i=1;
k=1;
while (i <= m)
    if x(i,6) ~= 0 %������0Ϊͣ����
        Latemp=0;
        Lotemp=0;
        Altemp=0;
        Ttemp=0;
        for j=i:m  %��ȡ��i��ʼ��һ��ͣ��������������
            Latemp=Latemp+x(j,2);
            Lotemp=Lotemp+x(j,3);
            Altemp=Altemp+x(j,4);
            Ttemp=Ttemp+x(j,5);
            if j==m  %��ȡ�����������һ��
               y(k,:)=[k Latemp/(j-i+1) Lotemp/(j-i+1) Altemp/(j-i+1) Ttemp/(j-i+1) x(i,6)];%ȡƽ��������y
               i=j+1;  %ѭ������
            else if x(j+1,6) ~= x(i,6) %�����µ�ͣ����Ŀ�ʼ����;����
                y(k,:)=[k Latemp/(j-i+1) Lotemp/(j-i+1) Altemp/(j-i+1) Ttemp/(j-i+1) x(i,6)];%ȡƽ��������y
                k=k+1;
                i=j+1;
                break;
                end
            end
        end
    else
        y(k,:)=x(i,:);%;����
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

