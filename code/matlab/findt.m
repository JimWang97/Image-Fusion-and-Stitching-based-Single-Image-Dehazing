function [hh,C,apnum,lmd]=findt(darkchannelOri) 
    darkchannelOri=round(darkchannelOri*255);
    DMAX=max(max(darkchannelOri));
    DMIN=min(min(darkchannelOri));
    clear C;
    clear dis;
    %**************************************************************
%直接根据dc计算密度
%     for k=0:255
%         n=0;
%         count=0;
%         for m=max(0,k-5):min(255,k+5)
%         b=darkchannelOri==m;
%         n=sum(b(:))+n;
%         count=count+1;
%         end
%     n=n/count;
%     p(k+1,1)=n;
%     p(k+1,2)=k;
%     end
%************************************************************
    for k=0:255
        delta=0;count=0;
        for m=max(0,k-20):min(255,k+20)
             b=darkchannelOri==m;
             n=sum(b(:));
             d=1/(exp(abs(k-m)));
             delta=n*d+delta;
             count=count+1;
        end
        p(k+1,1)=delta;
        p(k+1,2)=k;
    end
    
    p=sortrows(p,-1);
    dis2(1)=max(DMAX-p(1,2),p(1,2)-DMIN);
    for k=2:256
        for j=1:k-1
            dis(j,1)=abs(p(k,2)-p(j,2));
            dis(j,2)=j;
        end
         dis=sortrows(dis);
         dis2(k)=dis(1,1);
    end
    p1=p(:,1);
    p1=p1';
    p2=p(:,2)';
   lmd=p1.*dis2;
   lmd=cat(1,lmd,p2);
   
   lmd=sortrows(lmd',-1);

   lmd(1:256,3)=[1:256];
   lmd=lmd';
%    lmd(1)=0;
sumap=0;
 for i=255:-1:2
     ap=abs(abs(lmd(1,i-1)-lmd(1,i))-abs(lmd(1,i)-lmd(1,i+1)));
     sumap=sumap+ap;
     ave=sumap/254;
 end
 apnum=0;
  for i=255:-1:2
     if abs(abs(lmd(1,i-1)-lmd(1,i))-abs(lmd(1,i)-lmd(1,i+1)))>ave
         apnum=lmd(3,i);
         break;
     end
 end


   bb=[1:256];
   hh=scatter(bb,lmd(1,:));
   if apnum~=0
   C(2,1:apnum)=lmd(2,1:apnum)./255;
   C(1,1:apnum)=lmd(1,1:apnum);
   else
   C=[0];
   end
end


