function [f_rgb,markImg,markImg2]=lab_markImg(h,w,NUM,ind,f_rgb,num)
color_f=zeros(3,NUM);
markImg_r=zeros(h,w);
markImg_g=zeros(h,w);
markImg_b=zeros(h,w);
markImg=zeros(h,w,3);
markImg2=zeros(h,w,3);
if f_rgb==0
    f_rgb=rand(1,3,NUM);
end

for i=1:NUM
   markImg_r(ind==i)=f_rgb(1,1,i);
   markImg_g(ind==i)=f_rgb(1,2,i);
   markImg_b(ind==i)=f_rgb(1,3,i);
end
markImg(:,:,1)=markImg_r;
markImg(:,:,2)=markImg_g;
markImg(:,:,3)=markImg_b;

if num~=0
   markImg_r(ind~=num)=0;
   markImg_g(ind~=num)=0;
   markImg_b(ind~=num)=0;
   markImg_r(ind==num)=1;
   markImg_g(ind==num)=1;
   markImg_b(ind==num)=1;
   markImg2(:,:,1)=markImg_r;
   markImg2(:,:,2)=markImg_g;
   markImg2(:,:,3)=markImg_b;
end