function [neighb,K] = calcAdjancency( Mask,IND )
 
[height, width]      = size(Mask);
total=height*width;

i1 = (1:total-height)';
j1 = i1+height;
i2 = (1+height:total)';
j2 = i2-height;
for i = 1:width
      i3_tem(:,i) = (i-1)*height + (1:height-1)';
end
i3 = i3_tem(:);
j3 = i3+1;

for i = 1:width
      i4_tem(:,i) = (i-1)*height + (2:height)';
end
i4 = i4_tem(:);
j4 = i4-1;

all=[[i1;i2;i3;i4],[j1;j2;j3;j4],[ones(size(i1));ones(size(i2));ones(size(i3));ones(size(i4))]];
neighb = spconvert(all);
SUM=double(sum(neighb,2));
K=reshape(SUM,[height,width]);

elementInDiag = SUM;
A = spdiags (elementInDiag, 0, total, total);
neighb=A-neighb;
neighb(IND,IND)=neighb(IND,IND)+1;