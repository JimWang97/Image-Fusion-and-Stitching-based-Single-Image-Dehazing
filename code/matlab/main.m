clear all;
%%
%循环读取图像
for i=1:92
    clear easyout finalout weight I iniT GamaI Alight darkchannel sky Img BIGSKYWEIGHT output out1 out count NoI;
    str=['D:\learning\image\' num2str(i) '.bmp'];
    I=im2double(imread(str));
    str=['D:\learning\matlabCode\matlabCode\科研\CLAHE原图\' num2str(i) '.bmp'];
    NoI = im2double(imread(str));
    dir=['D:\learning\matlabCode\matlabCode\科研\NewAT\0test0924-final\'];
%     Lab=rgb2lab(I);
%     L=Lab(:,:,1)/100;
%     L = adapthisteq(L,'clipLimit',0.005,'Distribution','rayleigh');
%     Lab(:,:,1) = L*100;
%     NoI = lab2rgb(Lab);
%     imshow(I);
%     figure;
%     imshow(NoI);
%     I = imread('tire.tif');
%     NoI(:,:,1) = adapthisteq(I(:,:,1),'clipLimit',0.002,'Distribution','rayleigh');
%     NoI(:,:,2) = adapthisteq(I(:,:,2),'clipLimit',0.002,'Distribution','rayleigh');
%     NoI(:,:,3) = adapthisteq(I(:,:,3),'clipLimit',0.002,'Distribution','rayleigh');
%     imwrite(NoI,[dir 'clahe\' num2str(i) '_0913.bmp']);
%     imshowpair(I,NoI,'montage');
%%
%对原图伽马校正   
    iniI=mean(NoI,3);
    [H,W,~] = size(I);
    GamaNoI=NoI;
    GamaNoI1=GamaCorrection(I,0.43,0.7,H,W);
%     GamaI=GamaCorrection(I,0.43,0.7,H,W);
%%
%计算A 暗通道 和原始的T
    darkchannel=calcDarkChannel(I,7);
    ALight=GetALight(I);
%%
%求天空区域
    [sky]=GetSky(GamaNoI1,H,W,i,I);
    SKY=sky;
    SKY(SKY>0.6)=1;
% %%
% % 筛选代表性A
%     RepresentativeA=FindMyA(ALight);
% 
% %%
% %融合
% NUM=1;
% 
% for num=1:length(RepresentativeA(1,:,3))
% %获得需要的A
%     A=RepresentativeA(1,num,:);
% %计算T，并筛选代表性样本
%     iniT=1-0.95*darkchannel/min(A(1,:));
%     GuideT=guidedfilter_color(NoI,iniT,14,0.0001);
%     RepresentativeT=FindMyT(GuideT,SKY);
%     
% % 扩充
%    [Img,BIGSKYWEIGHT]=BIG(H,W,GamaNoI,SKY);
% 
% %去雾
%     if length(RepresentativeT)>=3
%      [output,count]=defogging(Img,A,RepresentativeT,i,dir);
% 
% %融合 裁剪
%      out1=fusionTest(output,count-1,i,BIGSKYWEIGHT,iniI,H,W,GuideT,NoI);
%      out=out1(1:H,1:W,1:3);
%      
% 
% %      imwrite(overmark{1,NUM},[dir 'fusion\' num2str(i) '_' num2str(A) '_0808 over.bmp']);
% %      out(out<0)=0;
% %      out(out>1)=1;
% %      if flag==1
% %      R=out(:,:,1);
% %      G=out(:,:,2);
% %      B=out(:,:,3);
% %      r=NoI(:,:,1);
% %      g=NoI(:,:,2);
% %      b=NoI(:,:,3);
% %      R(SKY==1)=r(SKY==1);
% %      G(SKY==1)=g(SKY==1);
% %      B(SKY==1)=b(SKY==1);
% %      out=cat(3,R,G,B);
% %      end
% %融合结果
%      imshow(out);
%      input{1,NUM}=out;
%      NUM=NUM+1;
%      imwrite(out,[dir 'fusion\' num2str(i) '_' num2str(A) '_0924.bmp']);
%     end
% end

%%
%计算权重
%     weight=calcWeight(input,H,W,NUM-1,SKY,NoI);
%     [weightMAX,ind]=min(weight,[],3);
%     R=zeros(H,W);
%     G=zeros(H,W);
%     B=zeros(H,W);
%     for k=1:NUM-1
%         tempR=input{k}(:,:,1);
%         tempG=input{k}(:,:,2);
%         tempB=input{k}(:,:,3);
%         R(ind==k)=tempR(ind==k);
%         G(ind==k)=tempG(ind==k);
%         B(ind==k)=tempB(ind==k);
%     end
%     easyout(:,:,1)=R;
%     easyout(:,:,2)=G;
%     easyout(:,:,3)=B;
%     imwrite(easyout,[dir 'fusion\' num2str(i) '_0924.bmp']);
%     for K=[2650]
%     [midout,label,WEIGHT]=myMontage(H,W,weight,NUM-1,input,SKY,i,easyout,weightMAX,K,NoI);  
%     imshow(midout);
%     imwrite(midout,[dir 'final' num2str(K) '\' num2str(i) '_0924_' num2str(K) '.bmp']);
%     Finalout=gradientFuse(label,midout,input,WEIGHT,i,NoI,SKY,easyout);
%     imwrite(Finalout,[dir 'out'  '\' num2str(i) '_0924_final_' num2str(K) '.bmp']);
%    
%     end
end