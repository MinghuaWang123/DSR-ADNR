function Dict=ConstructionD_w(data,K,P)
[D,N]=size(data);
Dict1=data;
IDX=kmeans(data',K,'start','plus');
Dict=[];
 count=hist(IDX,unique(IDX));
 [a,ind]=sort(count,'descend');
 sum_ind = 0;
 for j = 1:length(ind)
     sum_ind = sum_ind + count(ind(j));
     if sum_ind/N > 0.7
         q=j;
         break;
     end
     
 end
 
for i=ind(1:q)
    pos=find(IDX==i);
    D_temp=data(:,pos);
    if(size(D_temp,2)<P)
        continue;
    end
    mu=mean(D_temp,2);
    COV_inv=pinv(cov(D_temp')); 
    D_temp_C=D_temp-repmat(mu,[1,size(D_temp,2)]);
    Dis=zeros(1,size(D_temp,2));
    for j=1:size(D_temp,2)
        Dis(j)=D_temp_C(:,j)'*COV_inv*D_temp_C(:,j);
    end
    [~,Ind]=sort(Dis);
%     Dict1(:,Ind(end-P+1:end))=0;
%     Dict1(:,Ind(1:P))=0;
    
    Dict=[Dict,D_temp(:,Ind(1:P))];
end
%  a=Dict1';
% a1=reshape(a,100,100,193);
% figure,imshow(a1(:,:,1),[]);
end