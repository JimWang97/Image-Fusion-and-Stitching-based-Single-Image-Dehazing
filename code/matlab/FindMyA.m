function AA=FindMyA(input)
[h,w,~]=size(input);
M=ones(1,h*w);
r=30/255;
A=input;
for i=1:h*w
    Dist(i)=A(1,i,1)^2+A(1,i,2)^2+A(1,i,3)^2;
end
[~,indexDist]=sort(Dist,'Descend');



for i=1:h*w
    count=0;
    k=1;
    while 1

            Distance=((A(1,indexDist(i),1)-A(1,indexDist(k),1))^2+(A(1,indexDist(i),2)-A(1,indexDist(k),2))^2+(A(1,indexDist(i),3)-A(1,indexDist(k),3))^2);
            if Distance<=r^2
                count=1/exp(Distance)+count;
            elseif Distance>r^2 && k>i
                break;
            end
            if k==h*w
                break;
            end
            k=k+1;
    end
    p(1,indexDist(i))=count;
end

[~,indexp]=sort(p,'Descend');
RepresentativeA(1,1,:)=A(1,indexp(1),:);

for i=1:h*w
    DIST(1,i)=(A(1,i,1)-A(1,indexp(1),1))^2+(A(1,i,2)-A(1,indexp(1),2))^2+(A(1,i,3)-A(1,indexp(1),3))^2;
end


DISTANCE=DIST;
k=2;
Mark=ones(h,w);
Mark(DIST<r^2)=0;
while 1
    W=DISTANCE.^2.*p;
    [~,pos]=max(W);
    for i=1:h*w
        D(i)=(A(1,i,1)-A(1,pos,1))^2+(A(1,i,2)-A(1,pos,2))^2+(A(1,i,3)-A(1,pos,3))^2;
    end
    if p(pos)>2
    RepresentativeA(1,k,:)=A(1,pos,:);
    
    k=k+1;
    end
    DISTANCE=min(DISTANCE,D);
    Mark(DISTANCE<r^2)=0;
    SUM=nnz(Mark);
    if SUM==0
        break;
    end
    
end

[~,figure,~]=size(RepresentativeA);
for i=1:figure
    for k=i+1:figure
        if ((RepresentativeA(1,i,1)-RepresentativeA(1,k,1))^2+(RepresentativeA(1,i,1)-RepresentativeA(1,k,1))^2)<r^2/4
            RepresentativeA(1,k,1)=NaN;
            RepresentativeA(1,k,2)=NaN;
            RepresentativeA(1,k,3)=NaN;
        end
    end
end
k=1;
for i=1:figure
    if isnan(RepresentativeA(1,i,:))
        
    else
    MyA(1,k,:)=RepresentativeA(1,i,:);
    k=k+1;
    end
end

[~,ind]=sort(sum(MyA,3),'descend');
for i=1:size(ind,2)
   AA(1,i,1)=MyA(1,ind(i),1); 
   AA(1,i,2)=MyA(1,ind(i),2); 
   AA(1,i,3)=MyA(1,ind(i),3); 
end
