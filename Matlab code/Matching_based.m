clear all;
clc;
Location = load('../Sample data/SymbolData.txt');
minSupport=2; %��С֧��Ƶ��
%%H=3;% match threshold
[m,n]=size(Location);
y=1;%���ݼ�¼λ��
for k=1:m  %%��ÿһ���켣����\
    for z=1:n  %%����������еĳ���
        if Location(k,z)==0
            z=z-1;
            break;
        end
    end
  %  z=n;
    for l=2:z  %%�ӹ켣�ĳ���
        r=1;%ÿһ�д�����Ĺ켣�洢λ��
        Temp=[];
        for i=1:z-l+1 %%�����ӹ켣������λ��
            count=0;%����
            repeat=1;%����Ĺ켣�Ƿ��ظ����ж�ֵ
            if r>1
            for  c=1:r-1
                if Location(k,i:i+l-1)== Temp(c,1:l)
                    repeat=0;
                end
            end
            end
            if repeat==1
            for j=i:z-l+1 %%�Ա��ӹ켣������λ��
                match=1;%�Ƿ�match���ж�ֵ
                for x=1:l %���ζԱ��ӹ켣�е�ÿһ��
                    if Location(k,i+x-1)~=Location(k,j+x-1)  %λ�ò�ƥ��
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
%�ϲ���ͬ�켣������Ƶ�ʹ켣
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

%������ʽ
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
        fprintf(fid,'%d\r\n',librarySum(i,n));%ÿһ�лس�\n    
    end 
fclose(fid);