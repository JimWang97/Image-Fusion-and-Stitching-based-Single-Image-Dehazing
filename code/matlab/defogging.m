function [input,count]=defogging(Img,ALight,T,i,dir)
count=1;
    w=0.95;
    for j=1:min(size(ALight))
        A=ALight(j,:);
    Amean=mean(A(1,:));
        for k=1:length(T)   
            if T>0
            J(:,:,1) = (Img(:,:,1) - A(1,1) * (1-T(k)))./T(k);
            J(:,:,2) = (Img(:,:,2) - A(1,2) * (1-T(k)))./T(k);
            J(:,:,3) = (Img(:,:,3) - A(1,3) * (1-T(k)))./T(k);
% 
%             J(J<0) = 0;
%             J(J>1) = 1;
         
            input{1,count}=J;
            
            str=[num2str(i)  '_time=' num2str(count) 'A=' num2str(Amean) ' t=' num2str(T(k)) ];
            imwrite(J,[dir 'NewResult\' str '.bmp']);
            count=count+1;
            end
        end
    end