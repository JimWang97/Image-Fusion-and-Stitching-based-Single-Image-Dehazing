function [out,OriLabel,energy,weightmean,nbmean]=alphaExp(Label,h,w,background,easyout,input,ground,OriLabel,labelnum,Potts_K,NoI)


[neighbours,nbmean] = calcneighbours(input,background,h,w,NoI);
neighbours=neighbours*Potts_K;
SmoothCost = eye(2);
SmoothCost = 1 - SmoothCost;
Label1=zeros(h,w);
Label1(Label==ground)=1;
Label1(Label~=ground)=2;
init_lable=reshape(Label1,[h*w 1]);
datacost = calcdatacost(background,easyout,input,h*w);
weightmean=[mean(mean(datacost(:,1))) mean(mean(datacost(:,2)))];
hist = GCO_Create(h*w,2);
GCO_SetLabeling(hist,init_lable);
GCO_SetDataCost(hist,datacost');
GCO_SetSmoothCost(hist,SmoothCost);
GCO_SetNeighbors(hist,neighbours);
GCO_SetVerbosity(hist,2);
GCO_ExpandOnAlpha(hist,2);
Labeling = GCO_GetLabeling(hist);
energy=GCO_ComputeEnergy(hist);
GCO_Delete(hist);

Labeling1(Labeling==1)=ground;
Labeling1(Labeling==2)=labelnum;
label = reshape(Labeling1,[h w]);
imgR=input(:,:,1);
imgG=input(:,:,2);
imgB=input(:,:,3);
R=background(:,:,1);
G=background(:,:,2);
B=background(:,:,3);

    R(label~=ground)=imgR(label~=ground);
    G(label~=ground)=imgG(label~=ground);
    B(label~=ground)=imgB(label~=ground);
    out(:,:,1)=R;
    out(:,:,2)=G;
    out(:,:,3)=B;
%     WEIGHT=weightG;
%     WEIGHT(label~=ground)=weightL(label~=ground);
    OriLabel(label~=ground)=label(label~=ground);
% [f,markImg,~]=lab_markImg(h,w,num,init_lable,0,0);
% imshow(markImg);
% label = reshape(Labeling,[h w]);
% [~,markImg1,~]=lab_markImg(h,w,num,label,f,0);
% figure;
% imshow(markImg1);

% img=zeros(h,w,3);
% CR=zeros(h,w);
% CG=zeros(h,w);
% CB=zeros(h,w);
% for i=1:num
%     R=input{i}(:,:,1);
%     G=input{i}(:,:,2);
%     B=input{i}(:,:,3);
%    CR(label==i)=R(label==i);
%    CG(label==i)=G(label==i);
%    CB(label==i)=B(label==i);
% end
% img(:,:,1)=CR;
% img(:,:,2)=CG;
% img(:,:,3)=CB;
% % figure;
% % imshow(img);
% 
% dir=['D:\matlabCode\NewAT\2018.08.06\'];
% imwrite(markImg,[dir 'final2\' num2str(inum) '_0806_ainitlabel.bmp']);
% imwrite(markImg1,[dir 'final2\' num2str(inum) '_0806_finallabel.bmp']);
% imwrite(img,[dir 'final2\' num2str(inum) '_0806_output.bmp']);