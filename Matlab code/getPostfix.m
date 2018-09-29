%%生成后缀

function [ library ] = getPostfix(Location,prefix,library_ini,cb,ce,minSupport,place)
    library=library_ini;
    [x,~]=size(prefix);    
for i=1:x  %%提取前缀
    if x~=1
    place=i;
    end
    y=1;%后缀序数
    [m,n]=size(Location);
    ceNew=ce;
    tempPostfix=[];
    tempPostfix(1,1)=0;
    for r=1:m  %%寻找这个前缀的所有后缀
        for c=1:n
            if Location(r,c)==prefix(i)
                for k=c:n   %%去掉后缀中的补零
                    if Location(r,k)==0
                        k=k-1;
                        break;
                    end
                end
                if c<k
                tempPostfix(y,1:k-c)=Location(r,c+1:k);%%生成后缀                
                y=y+1;
                end
                break
            end
        end    
    end
    %%计算支持度
    if tempPostfix(1,1)~=0
    [m,n]=size(tempPostfix);
    if m>=1 && n>=1
    list=[];
    list(1,1)=tempPostfix(1,1);
    y=2;%%后缀序数
    for k=1:m  %提取新前缀
        for j=1:n
          if ~ismember(tempPostfix(k,j),list)==1 && tempPostfix(k,j)~=0
             list(1,y)=tempPostfix(k,j);
             y=y+1;
          end
        end
    end   
    for k=1:y-1  %计算支持度,储存数据
        count=0;
        for j=1:m
            if ismember(list(1,k),tempPostfix(j,:))==1
                count=count+1;%计算支持度
            end
        end
        if count > minSupport   
           temp=[library(place,cb:ce-1) list(1,k) -count];
           [~,length]=size(temp); 
           library(place,ceNew+1:ceNew+length)= temp;  %存后缀入库
           cbNew=ceNew+1;
           ceNew=ceNew+length;
           library=getPostfix(tempPostfix,list(1,k),library,cbNew,ceNew,minSupport,place); %递归
           [~,cTemp]=size(library);%%生成新库之后，确定下次写入位置
           for j=1:cTemp
               if library(place,cTemp-j+1)<0
                   ceNew=cTemp-j+1;
                   break;
               end
           end
        end
    end
    end
    end
    
end
  
end


