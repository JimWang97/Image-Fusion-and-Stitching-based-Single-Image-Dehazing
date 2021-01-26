function [IN,Label,WEIGHT]=myMontage(H,W,weight,num,input,SKY,NUM,easyout,weightMAX,K,NoI)
[~,ind]=min(weight,[],3);
dir=['D:\learning\matlabCode\matlabCode\¿ÆÑÐ\NewAT\0test0924-final\'];
dinar=zeros(H,W,num);
MAXLIANTONG=zeros(H,W,num);
% J=figure;
% K=figure;
for i=1:num
   temp=zeros(H,W);
   temp(ind==i)=1;
   dinar(:,:,i)=temp;
   MAXLIANTONG(:,:,i)=maxLianTongYu(temp);
end

[~,ground]=max(sum(sum(dinar)));
% [~,ground]=min(sum(sum(weight)));
IN=input{ground};
% IN=easyout;
WEIGHT=zeros(H,W);
% WEIGHT=weightMAX;
[f,markImg,~]=lab_markImg(H,W,num,ind,0,0);
imshow(markImg);
Label=ones(H,W)*ground;
% energy0=0;
[f,markImg,~]=lab_markImg(H,W,num,Label,f,0);
% imwrite(markImg,[dir 'final\' num2str(NUM) '_' num2str(0) '_0830.bmp']);
% energy0=0;
% while(1)
for i=1:num
%     if i~=ground
        label=ones(H,W);
        label=label*ground;
%         label(MAXLIANTONG(:,:,i)==1)=i;
        [f,markImg,~]=lab_markImg(H,W,num,label,f,0);
        imshow(markImg);
%         imwrite(markImg,[dir 'final' num2str(K) '\' num2str(NUM) '_' num2str(i) '_0913_L.bmp']);
        [IN,Label,energy,wtmean,nbmean]=alphaExp(label,H,W,IN,easyout,input{i},ground,Label,i,K,NoI);
        [f,markImg,~]=lab_markImg(H,W,num,Label,f,0);
%         figure(J);
        imshow(markImg);
%         figure(K);
        imshow(IN);
%         imwrite(IN,[dir 'final' num2str(K) '\' num2str(NUM) '_' num2str(i) '_nb=' num2str(nbmean) 'wtGL=' num2str(wtmean) 'K' num2str(K) '_0913_MidOut.bmp']);
        imwrite(markImg,[dir 'final' num2str(K) '\' num2str(NUM) '_' num2str(i) '_0913_LABEL.bmp']);
%     end
end
% if energy~=energy0
%     energy0=energy;
% else
%     break;  
% end
end