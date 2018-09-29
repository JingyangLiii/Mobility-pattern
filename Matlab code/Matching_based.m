clear all;
clc;
Location = load('../Sample data/SymbolData.txt');
minSupport=2; %最小支持频率
%%H=3;% match threshold
[m,n]=size(Location);
y=1;%数据记录位置
for k=1:m  %%对每一条轨迹处理\
    for z=1:n  %%计算非零序列的长度
        if Location(k,z)==0
            z=z-1;
            break;
        end
    end
  %  z=n;
    for l=2:z  %%子轨迹的长度
        r=1;%每一行处理过的轨迹存储位置
        Temp=[];
        for i=1:z-l+1 %%参照子轨迹的所有位置
            count=0;%计数
            repeat=1;%计算的轨迹是否重复的判断值
            if r>1
            for  c=1:r-1
                if Location(k,i:i+l-1)== Temp(c,1:l)
                    repeat=0;
                end
            end
            end
            if repeat==1
            for j=i:z-l+1 %%对比子轨迹的所有位置
                match=1;%是否match的判断值
                for x=1:l %依次对比子轨迹中的每一项
                    if Location(k,i+x-1)~=Location(k,j+x-1)  %位置不匹配
                        match=0;
                        break;
                    end
                end
                if match==1
                   count=count+1;
                end
            end
            if count>=minSupport
            library(y,1:l+1)=[-count Location(k,i:i+l-1) ];
            Temp(r,1:l)=Location(k,i:i+l-1);
            r=r+1;
            y=y+1;
            end
            end
        end
    end
end
%合并不同轨迹产生的频率轨迹
libraryTemp=library;
[m,n]=size(libraryTemp);
k=1;
count=0;
for i=1:m
    if libraryTemp(i,1)~=0
        count=libraryTemp(i,1);
    for j=i+1:m
        if libraryTemp(j,1)~=0
        if libraryTemp(i,2:n)==libraryTemp(j,2:n)
            count=count+libraryTemp(j,1);
            libraryTemp(j,1)=0;
        end
        end
    end
    librarySum(k,:)=libraryTemp(i,:);
    librarySum(k,1)=count;
    k=k+1;
    libraryTemp(i,1)=0;
    end
end

%调整格式
[m,n]=size(librarySum);
for i=1:m
    k=0;
    for j=1:n
        if librarySum(i,j)==0
            k=j;
            break;
        end
    end
    if k~=0
    count=librarySum(i,1);
    librarySum(i,1:j-2)=librarySum(i,2:j-1);
    librarySum(i,j-1)=count;
    else
    count=librarySum(i,1);
    librarySum(i,1:j-1)=librarySum(i,2:j);
    librarySum(i,j)=count;        
    end
end

[m,n]=size(librarySum);
   fid = fopen('../Sample data/Frepattern_MB.txt', 'w');
    for i=1:m    
        for j=1:n-1    
           fprintf(fid,'%d\t',librarySum(i,j));    
        end    
        fprintf(fid,'%d\r\n',librarySum(i,n));%每一行回车\n    
    end 
fclose(fid);