 function [Ff,Ll,S]=weightMapPinjie(im,H,W,sky,NoI,i)
% dinarSky=zeros(H,W);
% dinarSky(sky>0.6)=sky(sky>0.6);
% im=round(im*255);
%  L = mean(im,3);
% h=fspecial('log');
% lapWeightmap=abs(imfilter(L,h,'replicate'))+eps;
% % lapWeightmap=lapWeightmap/(max(max(lapWeightmap)));
% singleDis=(im(:,:,1)+im(:,:,2)+im(:,:,3))/3;
%%

f_r=imgradient(NoI(:,:,1),'sobel');
f_g=imgradient(NoI(:,:,2),'sobel');
f_b=imgradient(NoI(:,:,3),'sobel');
f=sqrt(f_r.^2+f_g.^2+f_b.^2);

Gradientweight=zeros(H,W);
w=0.05;
Gradientweight(f<w)=1;
IMean=mean(NoI,3)*255;
Var=((IMean-NoI(:,:,1)*255).^2+(IMean-NoI(:,:,2)*255).^2+(IMean-NoI(:,:,3)*255).^2)/3;
Var(Var<=10)=0;
Var(Var~=0)=1;
LabI=rgb2lab(NoI);
LightI=LabI(:,:,1);
MaxL=max(max(LightI));
Dis=MaxL-LightI;
Var(Dis<=10)=1;
skyweight=Gradientweight.*Var;
skyweight(sky==1)=1;

F_r=imgradient(im(:,:,1),'sobel');
F_g=imgradient(im(:,:,2),'sobel');
F_b=imgradient(im(:,:,3),'sobel');
F=sqrt(F_r.^2+F_g.^2+F_b.^2);   
Ff=(f-w).*(F-f);
% Ff(Ff>2)=2;
Ff(skyweight==0&f<w)=Ff(skyweight==0&f<w)*(-1);
% opq=zeros(H,W);
% opq(F<0.2)=1;
% Ff=exp(Ff);

%%
L1=mean(NoI,3);
sky_r=NoI(:,:,1);
sky_g=NoI(:,:,2);
sky_b=NoI(:,:,3);
sky_r=mean(mean(sky_r(sky~=0)));
sky_g=mean(mean(sky_g(sky~=0)));
sky_b=mean(mean(sky_b(sky~=0)));
min_c=min([sky_r,sky_g,sky_b]);
B=mean(mean(sky_b));
Lz=min(min(L1(sky~=0)));
if isempty(Lz)
    Lz=max(max(max(L1)));
end
Lz=ones(H,W).*Lz;


L2=mean(im,3);
% if (~isempty(Lz)&&Lz>0.5)
%     L1(L1>Lz)=Lz./(1-Lz).*(L1(L1>Lz)-Lz)+Lz;
%     L2(L1>Lz)=Lz./(1-Lz).*(L2(L1>Lz)-Lz)+Lz;
% end
% if (~isempty(Lz)&&Lz<0.5)
%     L1(L1<Lz)=(1-Lz)./Lz.*(L1(L1<Lz)-Lz)+Lz;
%     L2(L1<Lz)=(1-Lz)./Lz.*(L2(L1<Lz)-Lz)+Lz;
% end
% Ll=zeros(H,W);
Ll=(L1-Lz).*(L2-L1)./(abs(L1-Lz));
if (B>min_c)
    L1=max(NoI,[],3);
    L2=max(im,[],3);
    Ll(sky~=0)=-1.*abs(L2(sky~=0)-L1(sky~=0));
end
% Ll(sky~=1)=(L1(sky~=1)-Lz2).*(L2(sky~=1)-L1(sky~=1));
% Ll(Ll>1)=1;
% Ll=exp(Ll);
% op=zeros(H,W);
%     op(L1<Lz)=1;
%     imwrite(op,['E:\university\ÊîÆÚ¶ÍÁ¶\È¥Îí\2018.08.18\New A T\final\' num2str(i) '__0818.bmp']);
%%
% S=sqrt((((im(:,:,1)-NoI(:,:,1)).^2+(im(:,:,2)-NoI(:,:,2)).^2+(im(:,:,3)-NoI(:,:,3)).^2)/3));
S=(max(im,[],3)-min(im,[],3))./max(im,[],3)-(max(NoI,[],3)-min(NoI,[],3))./max(NoI,[],3);
%%
% lenth=H-16*floor(H/16)+17; 
% height=W-16*floor(W/16)+17;



% weight=lapWeightmap;
% weight(dinarSky>0)=singleDis(dinarSky>0);

end