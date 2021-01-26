function [enhancedImage,Iweight]=fusionMain2(input,inputNum,NUM,skyweight,iniI,Hh,WW,T,I)%weight只取前五个值
for i=1:inputNum
overmark{i}=markcastandover(I,input{i}(1:Hh,1:WW,1:3));
end
weight=cell(1,inputNum);
Cweight=cell(1,inputNum);
Dweight=cell(1,inputNum);
Iweight=cell(1,inputNum);
[H,W,~]=size(input{1});
for i = 1:inputNum;
     [weight{i},Overmark{i},~] = weightMap(input{i},iniI,Hh,WW,T,overmark{i},skyweight);
     Cweight{i} = weight{i};
     Dweight{i} = weight{i};
     input{i}(input{i}>1)=1;
     input{i}(input{i}<0)=0;
     Z(:,:,i) = weight{i}; 
end      
% for i=1:inputNum           
%       Z(:,:,i) = weight{i}; 
% end
% MAX=max(Z,[],3);
% 
% for i = 1:inputNum
%     Weight{i}=weight{i}./MAX;
% %     ZZ = fspecial('gaussian',16,16);  
% %     Weight{i} = imfilter(weight{i},ZZ,'symmetric');  
%     Cweight{i} = Weight{i};
%     Dweight{i} = Weight{i};
% %     Dweight{i}(Overmark{i}==0)=inf;
%     input{i}(input{i}>1)=1;
%     input{i}(input{i}<0)=0;
%     Z(:,:,i) = weight{i}; 
% end     
 X = sort(Z,3,'descend');
% Cweight{1}=Cweight{1}*10;
% Cweight{2}=Cweight{2}*5;
% Cweight{3}=Cweight{3}*1;
 M = X(:,:,3);
 Y=sort(Z,3,'ascend');
 N= Y(:,:,3);
    for i=1:inputNum
      Cweight{i}(Cweight{i}<M) = 0;
%       Dweight{i}(Dweight{i}>N)=0;
         if(i==1)
             CweightSum=Cweight{i};
%              DweightSum=Dweight{i};
         else
             CweightSum=CweightSum+Cweight{i};
%              DweightSum=DweightSum+Dweight{i};
         end

    end
%  NewDweightSum=zeros(H,W);
% for i=1:inputNum        
%         [row, col] = find(  Dweight{i} == 0 );
%         Dweight{i}=DweightSum-Dweight{i};
%         num = size(row, 1);
%         for iii = 1:num    
%              Dweight{i}(row(iii), col(iii)) = 0;
%         end
%         NewDweightSum=NewDweightSum+Dweight{i};
% end



    clear row iii col num;
for i=1:inputNum
        Iweight{i}=zeros(H,W);
         Iweight{i}(1:H,1:W)=(Cweight{i}./CweightSum);
%         Iweight{i}(1:H,1:W)=Cweight{i}./CweightSum;
%          J=input{i};
%          K=Iweight{i};
%          [row, col] = find( K ~= 0 );
%          num = size(row, 1); 
%          for iii = 1:num
%              J(row(iii), col(iii),1) = 255; 
%              J(row(iii), col(iii),2) = 0;
%              J(row(iii), col(iii),3) = 0;
%         end
%          str=[num2str(I)  '_time=' num2str(i)  ' mark'];
%                  imwrite(J,['NewResult\' str '.bmp']);
end

I=zeros(H,W,3);
GG=zeros(H,W,3);
for h=1:H
    for w=1:W
        k=1;
        for i=1:inputNum
            if Iweight{i}(h,w)~=0
                I(h,w,k)=i;
                GG(h,w,k)=Iweight{i}(h,w);
                k=k+1;
            end
        end
    end
end
   enhancedImage=multiScaleFusion(input,Iweight,H,W,inputNum);

end