function [weight,overmark,lumWeightmap]=weightMap(im,L2,H,W,T,overmark,skyweight)


 sigmaE=0.25;
 im=im(1:H,1:W,1:3);
 im2=min(im,[],3);
 im3=max(im,[],3);
 im4=median(im,3);
 im(im>1)=1;
 im(im<0)=0;

 L = mean(im,3);
% salWeightmap= sqrt(  ((im(:, :, 1) - L).^2 + (im(:, :, 2) - L).^2 + (im(:, :, 3) - L).^2)/3)+eps;
im=rgb2hsv(im);
im_s=im(:,:,2);
im_s=im_s./(max(max(im_s)));
m=min(im,[],3);
m2=max(im_s,[],3);
case1=m2==0;
idx=find(case1==1);
% salWeightmap(idx)=1*eps;
% im_s(idx)=1*eps;
R=im(:,:,1);
G=im(:,:,2);
B=im(:,:,3);
h=fspecial('log');
l1=abs(imfilter(R,h,'replicate'));
l2=abs(imfilter(G,h,'replicate'));
l3=abs(imfilter(B,h,'replicate'));
l=l1+l2+l3;
% lumWeightmap2=exp(-((L-0.5).^2)/(2*sigmaE^2))+eps;


% x=L./L2;
% c1=0.1;
% c2=1.9;
% a1=(1-T)/((c1-1).^2);
% a2=(1-T)/((c2-1).^2);
% y1=(a1.*(x-1).^2+T).*(x>=c1&x<=1);
% y2=(a2.*(x-1).^2+T).*(x>1&x<=c2);
% y3=(1/c1)*x.*(x<c1&x>0);
% y4=((-1/(2-c2))*(x-c2)+1).*(x>c2&x<2);
% y=y1+y2+y3+y4;

x=L./L2;
c1=T;
c2=2-T;
a1=(1-T)./((c1-1).^2);
a2=(1-T)./((c2-1).^2);
a1(isnan(a1) | a1==inf )=0;
a2(isnan(a2) | a2==inf)=0;
y1=(a1.*(x-1).^2+T).*(x>=c1&x<=1);
y2=(a2.*(x-1).^2+T).*(x>1&x<=c2);
y3=(1./c1).*x.*(x<c1&x>0);
y4=((-1./(2-c2)).*(x-c2)+1).*(x>c2&x<2);
y=y1+y2+y3+y4+eps;
y(T==1|T<=0|isnan(x)|x==inf)=0;

lumWeightmap=y;
lumWeightmap=lumWeightmap+eps;
lumWeightmap=lumWeightmap./(max(max(lumWeightmap)));
lenth=H-16*floor(H/16)+17; 
height=W-16*floor(W/16)+17;
    
lumWeightmap=padarray(lumWeightmap,[lenth height],'replicate');
lapWeightmap=padarray(l,[lenth height],'replicate');
ycWeightmap=zeros(H,W);
ycWeightmap=(((-im2.^2+1))).*(im2>=-1&im2<0&im4>0)+1*(im2>=0&im2<=1&im3>=0&im3<=1)+(-(im3-1).^2+1).*(im3>=1&im3<=2&im4<1)+eps;

ycWeightmap=padarray(ycWeightmap,[lenth height],'replicate');
overmark=padarray(overmark,[lenth height],'replicate');

lumWeightmap=lumWeightmap(1+lenth:end,1+height:end);
lapWeightmap=lapWeightmap(1+lenth:end,1+height:end);
ycWeightmap=ycWeightmap(1+lenth:end,1+height:end);
overmark=overmark(1+lenth:end,1+height:end);

weight=lapWeightmap.*lumWeightmap.*ycWeightmap+eps;
weight(skyweight>=0.6)=exp(-lapWeightmap(skyweight>=0.6))+eps;
weight(overmark==0)=eps;
% weight(overmark==0&skyweight>=0.6)=inf;
% weight=lapWeightmap.*lumWeightmap;
% weight=lumWeightmap;

end