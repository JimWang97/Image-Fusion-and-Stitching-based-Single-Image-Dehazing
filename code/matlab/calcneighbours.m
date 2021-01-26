function [Neighbours,MEAN]=calcneighbours(input,background,h,w,NoI)
ingray=rgb2gray(input);
backgray=rgb2gray(NoI);
imgR=input(:,:,1);
imgG=input(:,:,2);
imgB=input(:,:,3);
R=background(:,:,1);
G=background(:,:,2);
B=background(:,:,3);
templt = [0 0 0; 0 -1 1; 0 0 0];
GRX1 = imfilter(double(imgR), templt, 'replicate');%Rx�ݶ�
GGX1 = imfilter(double(imgG), templt, 'replicate');%Gx�ݶ�
GBX1 = imfilter(double(imgB), templt, 'replicate');%Bx�ݶ�
templt = [0 0 0; 0 -1 0; 0 1 0];
GRY1 = imfilter(double(imgR), templt, 'replicate');%Ry�ݶ�
GGY1 = imfilter(double(imgG), templt, 'replicate');%Gy�ݶ�
GBY1 = imfilter(double(imgB), templt, 'replicate');%By�ݶ�
templt = [0 0 0; 0 -1 1; 0 0 0];
GRX2 = imfilter(double(R), templt, 'replicate');%Rx�ݶ�
GGX2 = imfilter(double(G), templt, 'replicate');%Gx�ݶ�
GBX2 = imfilter(double(B), templt, 'replicate');%Bx�ݶ�
templt = [0 0 0; 0 -1 0; 0 1 0];
GRY2 = imfilter(double(R), templt, 'replicate');%Ry�ݶ�
GGY2 = imfilter(double(G), templt, 'replicate');%Gy�ݶ�
GBY2 = imfilter(double(B), templt, 'replicate');%By�ݶ�
totalsizes=h*w;
m=h;
n=w;
%% 
%%

    %������������--���ɾ����ϡ�����
    i1 = (1:totalsizes-m)';                             
    j1 = i1+m;
    for i = 1:n
        i2_tem(:,i) = (i-1)*m + (1:m-1)';
    end
    i2 = i2_tem(:);
    j2 = i2+1;
    %��Ӧ�ߵ�ֵ
    mark1=exp(-(backgray(i1(:))-backgray(j1(:))).^2/(2*0.09));
    mark2=exp(-(backgray(i2(:))-backgray(j2(:))).^2/(2*0.09));
    mark1(mark1==1)=0;
    mark2(mark2==1)=0;
    ans1 = ((GRX1(i1(:))-GRX2(i1(:))).^2+(GGX1(i1(:))-GGX2(i1(:))).^2+(GBX1(i1(:))-GBX2(i1(:))).^2).^0.5...
        +((GRX1(j1(:))-GRX2(j1(:))).^2+(GGX1(j1(:))-GGX2(j1(:))).^2+(GBX1(j1(:))-GBX2(j1(:))).^2).^0.5+mark1;
%         +((imgR(i1(:))-R(i1(:))).^2+(imgG(i1(:))-G(i1(:))).^2+(imgB(i1(:))-B(i1(:))).^2).^0.5...
%         +((imgR(j1(:))-R(j1(:))).^2+(imgG(j1(:))-G(j1(:))).^2+(imgB(j1(:))-B(j1(:))).^2).^0.5...
%         +mark1;
% %         +1./sqrt(GRX2(i1(:)).^2+GGX2(i1(:)).^2+GBX2(i1(:)).^2);

    ans2 = ((GRY1(i2(:))-GRY2(i2(:))).^2+(GGY1(i2(:))-GGY2(i2(:))).^2+(GBY1(i2(:))-GBY2(i2(:))).^2).^0.5...
        +((GRY1(j2(:))-GRY2(j2(:))).^2+(GGY1(j2(:))-GGY2(j2(:))).^2+(GBY1(j2(:))-GBY2(j2(:))).^2).^0.5+mark2;
%         +((imgR(i2(:))-R(i2(:))).^2+(imgG(i2(:))-G(i2(:))).^2+(imgB(i2(:))-B(i2(:))).^2).^0.5...
%         +((imgR(j2(:))-R(j2(:))).^2+(imgG(j2(:))-G(j2(:))).^2+(imgB(j2(:))-B(j2(:))).^2).^0.5...
%         +mark2;
% %         +1./sqrt(GRY2(i2(:)).^2+GGY2(i2(:)).^2+GBY2(i2(:)).^2);
%     ans1=exp(-(backgray(i1(:))-backgray(j1(:))).^2/(2*0.01)).*mark(i1(:));
%     ans2=exp(-(backgray(i2(:))-backgray(j2(:))).^2/(2*0.01)).*mark(i2(:));
    %�����Ӧ��������xλ�ã�yλ�ã�Ȩֵ��ע����붼����������
    MEAN=[mean(ans1) mean(ans2)];
    all = [[i1;i2],[j1;j2],[ans1;ans2]];
    
%matlab��������ϡ�������ô�����ٶ���죩 %----------------
neighb = spconvert(all);
neighb(totalsizes,totalsizes) = 0; 
Neighbours = neighb;






