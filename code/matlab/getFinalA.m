function finalA=getFinalA(A,AOri)
[~,w,~]=size(A);
magnitude=AOri(1)^2+AOri(2)^2+AOri(3)^2;
for i=1:w
    magnitudeA=A(1,i,1)^2+A(1,i,2)^2+A(1,i,3)^2;
    r=magnitudeA/magnitude;
    r=r^0.5;
    finalA(1,i,:)=AOri*r;
end