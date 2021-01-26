function [SourceImg]=ReadyForFuse(NoFuseOut,label,input,labelnum,num)
mark=zeros(num,num);
[H,W,~]=size(NoFuseOut);
H=uint8(H);
W=uint8(W);
h=fspecial('log');
k=abs(imfilter(label,h,'replicate'));
k(k>0)=1;
[indx,indy]=find(k==1);
for i=1:size(indx,1)
        mark(label(indx(i),indy(i)),label(indx(i),min(W,1+indy(i))))=1;
        mark(label(indx(i),indy(i)),label(indx(i),max(1,indy(i)-1)))=1;
        mark(label(indx(i),indy(i)),label(max(1,indx(i)-1),indy(i)))=1;
        mark(label(indx(i),indy(i)),label(min(H,indx(i)+1),indy(i)))=1;
        mark(label(indx(i),indy(i)),label(indx(i),indy(i)))=0;
end

Order=zeros(1,num);
Order(1)=labelnum;
[ind]=find(mark(labelnum,:)==1;
Order(2)=ind(1);
h=3;
while 1
    tmep=zeros(1,num);
    for j=1:h
        temp=temp+label(Order(j),:);
    end
    temp(temp>1)=1;
    for j=1:num
        if sum(temp.*label(j,:))==0
            Order(h)=j;
            h=h+1;
        end
    end
    if h==num
        break;
    end
end
R=input(:,:,1);
G=input(:,:,2);
B=input(:,:,3);
for h=1:num
    SourceImg{Order(h)}=zeros(H,W,3);
    SourceImg{Order(h)}(:,:,1)=R(label==Order(h))+SourceImg{Order(h)}(:,:,1);
    SourceImg{Order(h)}(:,:,2)=G(label==Order(h))+SourceImg{Order(h)}(:,:,2);
    SourceImg{Order(h)}(:,:,3)=B(label==Order(h))+SourceImg{Order(h)}(:,:,3);
end