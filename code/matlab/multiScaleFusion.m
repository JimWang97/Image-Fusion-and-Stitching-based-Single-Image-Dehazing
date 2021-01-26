function enhancedImage=multiScaleFusion(I,weight,H,W,inputNum)
gaussianPyramid{inputNum}=[];
laplacianPyramid{3}{inputNum}=[];
laplacianPyramid{2}{inputNum}=[];
laplacianPyramid{1}{inputNum}=[];
%权重图下采样 待融合图三通道下采样
for i=1:inputNum
gaussianPyramid{i}= genPyr(weight{i},'gauss',5);
laplacianPyramid{1}{i}=genPyr(I{i}(:,:,1),'laplace',5);
laplacianPyramid{2}{i}=genPyr(I{i}(:,:,2),'laplace',5);
laplacianPyramid{3}{i}=genPyr(I{i}(:,:,3),'laplace',5);
end
for i=1:5
    T=0;
    for k=1:inputNum
%         T{k}=gaussianPyramid{k}{i};
        T=T+gaussianPyramid{k}{i};
    end
    
%     T=fusionMain3(T,inputNum);
%     for k=1:inputNum
%         gaussianPyramid{k}{i}=T{k};
%     end
end
clear I;
clear weight;
for i = 1 : 5
    tempImg = [];
    for j = 1 : 3
      
        rowSize = min([size(laplacianPyramid{j}{1}{i},1),size(gaussianPyramid{1}{i},1)]);
        columnSize = min([size(laplacianPyramid{j}{1}{i},2),size(gaussianPyramid{1}{i},2)]);
        
        for k=1:inputNum
        if(k==1)
            tempImg(:,:,j)=laplacianPyramid{j}{k}{i}(1:rowSize , 1:columnSize) .* gaussianPyramid{k}{i}(1:rowSize, 1:columnSize);
        else
            tempImg(:,:,j) = laplacianPyramid{j}{k}{i}(1:rowSize , 1:columnSize) .* gaussianPyramid{k}{i}(1:rowSize, 1:columnSize) + tempImg(:,:,j);
        end
        end
    end
    fusedPyramid{i} = tempImg;
end

enhancedImage = pyrReconstruct(fusedPyramid);
end