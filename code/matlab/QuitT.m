function [quitT]=QuitT(DC)
dc=10/255;
DC=DC';
DC=sortrows(DC,-1);
DC=DC';

for i=1:length(DC(1,:))
    for j=1:length(DC(1,:));
        if i~=j&&DC(2,i)~=0&&DC(2,j)~=0
            if abs(DC(2,i)-DC(2,j))<dc
                DC(2,j)=0;
            end     
        end
    end
end
DC=DC(2,:);
DC(DC==0)=[];
quitT=DC;
end