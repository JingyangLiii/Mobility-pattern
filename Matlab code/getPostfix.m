%%���ɺ�׺

function [ library ] = getPostfix(Location,prefix,library_ini,cb,ce,minSupport,place)
    library=library_ini;
    [x,~]=size(prefix);    
for i=1:x  %%��ȡǰ׺
    if x~=1
    place=i;
    end
    y=1;%��׺����
    [m,n]=size(Location);
    ceNew=ce;
    tempPostfix=[];
    tempPostfix(1,1)=0;
    for r=1:m  %%Ѱ�����ǰ׺�����к�׺
        for c=1:n
            if Location(r,c)==prefix(i)
                for k=c:n   %%ȥ����׺�еĲ���
                    if Location(r,k)==0
                        k=k-1;
                        break;
                    end
                end
                if c<k
                tempPostfix(y,1:k-c)=Location(r,c+1:k);%%���ɺ�׺                
                y=y+1;
                end
                break
            end
        end    
    end
    %%����֧�ֶ�
    if tempPostfix(1,1)~=0
    [m,n]=size(tempPostfix);
    if m>=1 && n>=1
    list=[];
    list(1,1)=tempPostfix(1,1);
    y=2;%%��׺����
    for k=1:m  %��ȡ��ǰ׺
        for j=1:n
          if ~ismember(tempPostfix(k,j),list)==1 && tempPostfix(k,j)~=0
             list(1,y)=tempPostfix(k,j);
             y=y+1;
          end
        end
    end   
    for k=1:y-1  %����֧�ֶ�,��������
        count=0;
        for j=1:m
            if ismember(list(1,k),tempPostfix(j,:))==1
                count=count+1;%����֧�ֶ�
            end
        end
        if count > minSupport   
           temp=[library(place,cb:ce-1) list(1,k) -count];
           [~,length]=size(temp); 
           library(place,ceNew+1:ceNew+length)= temp;  %���׺���
           cbNew=ceNew+1;
           ceNew=ceNew+length;
           library=getPostfix(tempPostfix,list(1,k),library,cbNew,ceNew,minSupport,place); %�ݹ�
           [~,cTemp]=size(library);%%�����¿�֮��ȷ���´�д��λ��
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


