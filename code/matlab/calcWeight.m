function Iweight=calcWeight(input,H,W,inputNum,skyweight,NoI)%,overmark
weight=zeros(H,W,inputNum);
F=zeros(H,W,inputNum);
L=zeros(H,W,inputNum);
for k=1:inputNum
    [Ff,Ll,S]=weightMapPinjie(input{k},H,W,skyweight,NoI);
%     weight(:,:,k)=temp(1:H,1:W);%.*overmark{k};
    F(:,:,k)=Ff(1:H,1:W)*10;
    L(:,:,k)=Ll(1:H,1:W)*10;
    S(:,:,k)=Ll(1:H,1:W)*10;
end
MAXF=max(F,[],3);
MAXL=max(L,[],3);
MAXS=max(S,[],3);
for k=1:inputNum
F(:,:,k)=exp(-(F(:,:,k)-MAXF).^2/(2*0.09));
L(:,:,k)=exp(-(L(:,:,k)-MAXL).^2/(2*0.09));
S(:,:,k)=exp(-(S(:,:,k)-MAXS).^2/(2*0.09));
a1=1;
a2=1;
a3=1;
% a1=0.5;
% a2=0.7;
% a3=0.5;
weight(:,:,k)=a1*F(:,:,k)+a2*L(:,:,k)+a3*S(:,:,k);%对比度 亮度 饱和度
end
MAX=max(weight,[],3);
temp=zeros(H,W);
for k=1:inputNum
    Iweight(:,:,k)=weight(:,:,k);
%     w{k}=weight(:,:,k);
    temp=Iweight(:,:,k);
%     temp(overmark{k}==0)=-100;
    Iweight(:,:,k)=MAX-temp;
end
% I3=Iweight(:,:,3);
% I8=Iweight(:,:,8);
% i=0;

