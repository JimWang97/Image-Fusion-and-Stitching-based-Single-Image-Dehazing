function [sky]=GetSky(GamaI,H,W,i,I)
clear f;
% dir=['D:\学习\matlabCode\matlabCode\科研\NewAT\2018.09.09\'];
dir=['E:\Learning\论文\论文图库\sky\'];
str=dir;
%% 高亮区域    
    GaussianMode=fspecial('gaussian', [36 36], 6);%fspecial('gaussian', hsize, sigma)产生滤波模板  
    %为了不出现黑边，使用参数'replicate'（输入图像的外部边界通过复制内部边界的值来扩展）  
    FilterI=imfilter(GamaI,GaussianMode,'replicate');  
    Filterdarkchannel=calcDarkChannel(FilterI,7);
    Maxd=max(max(Filterdarkchannel));
    HighLight=zeros(H,W);
    Imax=max(GamaI,[],3);
    limitMax=0.95*Maxd;
    HighLight(Imax>limitMax)=1;
    HighLight(HighLight<1)=0;
    imshow(HighLight);
%     colormap hot;
%     f=getframe(gcf);
    imwrite(HighLight,[str num2str(i) '_1亮度.bmp']);
%     clear f;
%% 梯度打分
    Gradientweight=sobelweight(I);
    K=Gradientweight;
    K(K>0)=1;
    imshow(Gradientweight);
%     colormap hot;
%     f=getframe(gcf);
    imwrite(K,[str  num2str(i) '_2梯度.bmp']);
%     clear f;
%% 浓雾判断
     IMean=mean(I,3)*255;
     Var=((IMean-I(:,:,1)*255).^2+(IMean-I(:,:,2)*255).^2+(IMean-I(:,:,3)*255).^2)/3;
     Var(Var<=10)=0;
     Var(Var~=0)=1;
     LabI=rgb2lab(I);
     LightI=LabI(:,:,1);
     MaxL=max(max(LightI));
     Dis=MaxL-LightI;
     Var(Dis<=10)=1;
     imshow(Var);
     O=Var;
     O(O==1)=2;
     O(O==0)=1;
     O(O==2)=0;
%     colormap hot;
%     f=getframe(gcf);
    imwrite(O,[str  num2str(i) '_3方差.bmp']);
%     clear f;
%% 综合
     SKYWEIGHT=Gradientweight.*HighLight.*Var;
%% 联通区域判断
%     MARK=ones(H,W);
%     sskyweight=ones(H,W);
%     sskyweight(skyweight<0.6)=0;
%     sskyweight= bwareaopen(sskyweight(:,:,1), 40);
%     sskyweight=double(sskyweight);
%     total=bwarea(sskyweight);
%     sskyweight(sskyweight==1)=2;
%     sskyweight(sskyweight==0)=1;
%     sskyweight(sskyweight==2)=0;
%     sskyweight= bwareaopen(sskyweight(:,:,1), 600);
%     sskyweight=double(sskyweight);
%     sskyweight(sskyweight==1)=2;
%     sskyweight(sskyweight==0)=1;
%     sskyweight(sskyweight==2)=0;
%     SKYWEIGHT=sskyweight.*skyweight;
%     MARK(SKYWEIGHT~=0)=1;
%     MARK(SKYWEIGHT==0)=2;
%     MARK=sskyweight-MARK;
%     [x,y]=find(MARK==-1);
%     [num,~,~]=size(x);
%     for M=1:num
%         MEDIAN=[skyweight(max(x(M)-1,1),y(M)),skyweight(min(H,x(M)+1),y(M)),skyweight(max(x(M)-1,1),max(1,y(M)-1)),skyweight(max(x(M)-1,1),min(W,y(M)+1)),skyweight(x(M),min(W,y(M)+1)),skyweight(x(M),max(1,y(M)-1)),skyweight(min(H,x(M)+1),max(1,y(M)-1)),skyweight(min(H,x(M)+1),min(W,y(M)+1))];
%         NEED=MEDIAN(MEDIAN>=0.6);
%         if ~isempty(NEED)
%         SKYWEIGHT(x(M),y(M))=min(NEED);
%         end
%     end
%     SKYWEIGHT(max(I,[],3)-min(I,[],3)>0.1)=0;&max(I,[],3)<0.8235
    A=SKYWEIGHT;
    A(A>0)=1;
    K=bwareaopen(A,1500);
    SKYWEIGHT=K.*SKYWEIGHT;
    sky=SKYWEIGHT;
    imshow(sky);
    a_sky=maxLianTongYu(sky);
    if sum(sum(sky(a_sky==1)))<10000
       sky=zeros(size(sky)); 
    end
    sky(sky~=0)=1;
    Sky=1-sky;
    Lab = bwlabel(Sky); 
    Num=max(max(Lab));
    for i1=1:Num
        [indx,indy]=find(Lab==i1);
        x1=min(indx);
        x2=max(indx);
        y1=min(indy);
        y2=max(indy);
        if x1==1||x2==H||y1==1||y2==W
            Lab(Lab==i1)=0;
        end
    end
    sky(Lab~=0)=1;
    SKYWEIGHT(SKYWEIGHT==0)=0.6;
    sky=sky.*SKYWEIGHT;
    imshow(sky);
%     colormap hot;
%     f=getframe(gcf);
    sky(sky>0)=1;
    imwrite(sky,[dir num2str(i) '_5final.bmp']);