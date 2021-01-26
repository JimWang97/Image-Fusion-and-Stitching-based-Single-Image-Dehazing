function weightmap=calcBoxWeight(weight,L,N,inputnum)
Sum=zeros(inputnum,N);
for j=1:inputnum
    for i = 1:N
        Sum(j,i)=sum(weight{j}(L==i));
    end
end

for i=1:N
    [sweight(i),weightmap(i)]=max(Sum(:,i));
end

for i=1:N
    if sweight(i)==0
        sweightmap(i)=0;
    end
end