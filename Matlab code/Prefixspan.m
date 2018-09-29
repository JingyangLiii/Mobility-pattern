clear all;
clc;
Location = load('../Sample data/SymbolData.txt');
minSupportRate = 0.4;
minSupport = 2; %��С֧�ֶ�
[m,n]=size(Location);
NumOfPrefix=max(max(Location));%ǰ׺������
FrePattern1=zeros(NumOfPrefix,20);%�洢����
%���ɵ�ǰ׺
k=1;
for i=1:NumOfPrefix
    count=0;
    for j=1:m
        if ismember(i,Location(j,:))==1
            count=count+1;
        end
    end
    FrePattern1(i,1) = i;
    FrePattern1(i,2) = -count;
    if count >=minSupport
        FrePattern2(k,:)= FrePattern1(i,:);
        k=k+1;
    end
end
library=getPostfix(Location,FrePattern2(:,1),FrePattern2,1,2,minSupport,1);
[m,n]=size(library);
   fid = fopen('../Sample data/Frepattern_prefix.txt', 'w');
    for i=1:m    
        for j=1:n-1    
           fprintf(fid,'%d\t',library(i,j));    
        end    
        fprintf(fid,'%d\r\n',library(i,n));%ÿһ�лس�\n    
    end 
fclose(fid);
