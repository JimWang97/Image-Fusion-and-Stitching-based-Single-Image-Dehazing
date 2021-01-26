function output=calcSmooth(input,h,w,num)
h=h+1;
w=w+1;
[H,W,~]=size(input);
K=[0 1 0;1 1 1;0 1 0];
output=zeros(num,num);
for i=1:num
    h1=imgradient(input{i}(:,:,1),'sobel');
    h2=imgradient(input{i}(:,:,2),'sobel');
    h3=imgradient(input{i}(:,:,3),'sobel');
    h1=padarray(h1,[1 1],'replicate');
    h2=padarray(h2,[1 1],'replicate');
    h3=padarray(h3,[1 1],'replicate');
    G{i}(:,:,1)=h1;
    G{i}(:,:,2)=h2;
    G{i}(:,:,3)=h3;
end
for i=1:num
    input{i}=padarray(input{i},[1 1],'replicate');
end
for i=1:num
    for j=1:num
        output(i,j)=sum(sum(((abs(input{i}(h-1:h+1,w-1:w+1,1)-input{j}(h-1:h+1,w-1:w+1,1)).*K).^2+...
            (abs(input{i}(h-1:h+1,w-1:w+1,2)-input{j}(h-1:h+1,w-1:w+1,2)).*K).^2+...
            (abs(input{i}(h-1:h+1,w-1:w+1,3)-input{j}(h-1:h+1,w-1:w+1,3)).*K).^2).*0.5))+...
            sum(sum(abs(G{i}(h-1:h+1,w-1:w+1)-G{j}(h-1:h+1,w-1:w+1)).*K));
    end
end
MAX=max(max(output));
output=round(output*100)./MAX ;
