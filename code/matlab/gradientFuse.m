function ResultImg=gradientFuse(label,finalout,input,weight,I,NoI,SKY,easyout)
L=unique(label);
if size(L,1)==1
   ResultImg=finalout;
else
[H,W]=size(label);
R=finalout(:,:,1);
G=finalout(:,:,2);
B=finalout(:,:,3);
%%
%求最大块亮度中值
% J=unique(label);    
% for i=1:size(J,1)
%     temp=label(label==J(i));
%     num(i)=sum(temp)/J(i);
% end
% light=(R+G+B)/3;
% midlight=median(median(light));
% K=abs(light-midlight);
% [~,ind]=max(num);
% temp=zeros(H,W);
% temp(label==J(ind))=1;
% temp=temp.*overmark{J(ind)};
% temp(temp==0)=NaN;
% K=K.*temp;
% MIN=min(min(K));
% IND=find(K==MIN);
% temp=zeros(H,W);
% temp(IND)=1;
% dir=['D:\matlabCode\科研\NewAT\2018.09.04\'];
% % imwrite(temp,[dir 'final\' num2str(I) '_0816_pixel.bmp']);
%%
%均分最低的那个块
J=unique(label);    

for i=1:size(J,1)
    temp=zeros(size(label));
    temp(label==J(i))=1;
    tempwei=weight;
    tempwei(SKY>=0.6)=10000;
    Wei(i)=mean(mean(tempwei.*temp));
end

[~,indm]=min(Wei);
[~,IND]=find(label==J(indm));
%%
%选亮度最低的点
% LIGHT=(R+G+B)/3;
% MIN=min(min(LIGHT));
% [~,IND]=find(LIGHT==MIN);
%%
%拼接梯度
    GRx=zeros(H,W);
    GGx=zeros(H,W);
    GBx=zeros(H,W);
    GRy=zeros(H,W);
    GGy=zeros(H,W);
    GBy=zeros(H,W);
    OVER=zeros(H,W);
    for j=1:size(L,1)
        templt = [0 0 0; 0 -1 1; 0 0 0];
        GR1 = imfilter(double(input{L(j)}(:,:,1)), templt, 'replicate');%Rx梯度
        GG1 = imfilter(double(input{L(j)}(:,:,2)), templt, 'replicate');%Gx梯度
        GB1 = imfilter(double(input{L(j)}(:,:,3)), templt, 'replicate');%Bx梯度
        templt = [0 0 0; 0 -1 0; 0 1 0];
        GR2 = imfilter(double(input{L(j)}(:,:,1)), templt, 'replicate');%Ry梯度
        GG2 = imfilter(double(input{L(j)}(:,:,2)), templt, 'replicate');%Gy梯度
        GB2 = imfilter(double(input{L(j)}(:,:,3)), templt, 'replicate');%By梯度
        GRx(label==L(j))=GR1(label==L(j));
        GGx(label==L(j))=GG1(label==L(j));
        GBx(label==L(j))=GB1(label==L(j));
        GRy(label==L(j))=GR2(label==L(j));
        GGy(label==L(j))=GG2(label==L(j));
        GBy(label==L(j))=GB2(label==L(j));
%         OVER(label==L(j))=overmark{L(j)}(label==L(j));
%         if j==ind
%                 gr1=GR1;
%                 gg1=GG1;
%                 gb1=GB1;
%                 gr2=GR2;
%                 gg2=GG2;
%                 gb2=GB2;
%         end
    end
%%
%显示梯度图
% GRx=GRx-min(min(GRx));
% GGx=GGx-min(min(GGx));
% GBx=GBx-min(min(GBx));
% GRy=GRy-min(min(GRy));
% GGy=GGy-min(min(GGy));
% GBy=GBy-min(min(GBy));
% TX=cat(3,GRx,GGx,GBx);
% TY=cat(3,GRy,GGy,GBy);
% imwrite(TX,[dir 'final\' num2str(I) '_0816_TX.bmp']);
% imwrite(TY,[dir 'final\' num2str(I) '_0816_TY.bmp']);
%%
%换梯度
gray=rgb2gray(NoI);
Imggradient=imgradient(gray,'sobel');
% templt = [0 1 0; 1 -4 1; 0 1 0];
% Labelgradient=abs(imfilter(label, templt, 'replicate'));
Imggradient(Imggradient>0.8)=1;
Imggradient(Imggradient~=1)=0;
% Labelgradient(Labelgradient~=0)=1;
% MASK=Imggradient.*Labelgradient;
% imwrite(Imggradient,[dir 'final50\' num2str(I) '_0904_Zedge.bmp']);
        templt = [0 0 0; 0 -1 1; 0 0 0];
        MARKGR1 = imfilter(double(finalout(:,:,1)), templt, 'replicate');%Rx梯度
        MASKGG1 = imfilter(double(finalout(:,:,2)), templt, 'replicate');%Gx梯度
        MASKGB1 = imfilter(double(finalout(:,:,3)), templt, 'replicate');%Bx梯度
        templt = [0 0 0; 0 -1 0; 0 1 0];
        MASKGR2 = imfilter(double(finalout(:,:,1)), templt, 'replicate');%Ry梯度
        MASKGG2 = imfilter(double(finalout(:,:,2)), templt, 'replicate');%Gy梯度
        MASKGB2 = imfilter(double(finalout(:,:,3)), templt, 'replicate');%By梯度    
% GRx(Imggradient==1)=MARKGR1(Imggradient==1);  
% GGx(Imggradient==1)=MASKGG1(Imggradient==1);
% GBx(Imggradient==1)=MASKGB1(Imggradient==1);
% GRy(Imggradient==1)=MASKGR2(Imggradient==1);
% GGy(Imggradient==1)=MASKGG2(Imggradient==1);
% GBy(Imggradient==1)=MASKGB2(Imggradient==1);
%%
%算散度
    templt = [0 0 0; -1 1 0; 0 0 0];
VR1 = imfilter(double(GRx), templt, 0);%Rx散度
VG1 = imfilter(double(GGx), templt, 0);%Gx散度
VB1 = imfilter(double(GBx), templt, 0);%Bx散度
% inivr1=imfilter(double(gr1), templt, 0);%Rx散度
% inivg1=imfilter(double(gg1), templt, 0);%Rx散度
% inivb1=imfilter(double(gb1), templt, 0);%Rx散度
templt = [0 -1 0; 0 1 0; 0 0 0];
VR2 = imfilter(double(GRy), templt, 0);%Ry散度
VG2 = imfilter(double(GGy), templt, 0);%Gy散度
VB2 = imfilter(double(GBy), templt, 0);%By散度
% inivr2=imfilter(double(gr2), templt, 0);%Rx散度
% inivg2=imfilter(double(gg2), templt, 0);%Rx散度
% inivb2=imfilter(double(gb2), templt, 0);%Rx散度
VR=VR1+VR2;
VG=VG1+VG2;
VB=VB1+VB2;
% inivr=inivr1+inivr2;
% inivg=inivg1+inivg2;
% inivb=inivb1+inivb2;
VR=-VR;
VG=-VG;
VB=-VB;
% inivr=-inivr;
% inivg=-inivg;
% inivb=-inivb;

    [A,~] = calcAdjancency(ones(H,W),IND(1));
    bR=reshape(VR,[H*W 1]);
    bG=reshape(VG,[H*W 1]);
    bB=reshape(VB,[H*W 1]);
%     bR(IND(1))=bR(IND(1))+R(IND(1));
%     bG(IND(1))=bG(IND(1))+G(IND(1));
%     bB(IND(1))=bB(IND(1))+B(IND(1));
    max_iter = 10000;
    tolerance = 1e-7;
    XR = cgs(sparse(A), bR, tolerance, max_iter, [], [], rand(H*W,1));
    XG = cgs(sparse(A), bG, tolerance, max_iter, [], [], rand(H*W,1));
    XB = cgs(sparse(A), bB, tolerance, max_iter, [], [], rand(H*W,1));
    ResultImgR=reshape(XR,[H W]);
    ResultImgG=reshape(XG,[H W]);
    ResultImgB=reshape(XB,[H W]);
    MR=mean(mean(easyout(:,:,1)));
MG=mean(mean(easyout(:,:,2)));
MB=mean(mean(easyout(:,:,3)));
ResultImgR=ResultImgR+MR-mean(mean(ResultImgR));
ResultImgG=ResultImgG+MG-mean(mean(ResultImgG));
ResultImgB=ResultImgB+MB-mean(mean(ResultImgB));
    ResultImg = cat(3, ResultImgR, ResultImgG, ResultImgB);
    imshow(ResultImg);
end