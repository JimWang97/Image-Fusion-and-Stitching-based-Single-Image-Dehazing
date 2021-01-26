function finalout=photomontage(weightmap,input,L,N)
finalout=input{1};
for i=1:N
   if weightmap(i)~=0
   M=input{weightmap(i)};
   M1=M(:,:,1);
   M2=M(:,:,2);
   M3=M(:,:,3);
   F1=finalout(:,:,1);
   F2=finalout(:,:,2);
   F3=finalout(:,:,3);
   F1(L==i)=M1(L==i);
   F2(L==i)=M2(L==i);
   F3(L==i)=M3(L==i);
   finalout(:,:,1)=F1;
   finalout(:,:,2)=F2;
   finalout(:,:,3)=F3;
   end
   imshow(finalout);
end
