function enhancedImage=fusionTest(input,count,k,skyweight,iniI,H,W,T,I)
% clear all;  %融合主函数，调用fusionmain

% fileFolder=fullfile('.');
% fileFolder_img = char(strcat(fileFolder, '\NewResult'));
% dirOutput=dir(fullfile(fileFolder_img,'*'));
% fileNames={dirOutput.name};

i =3+25*0;
% while(1)
% %     input=cell(1,25);
% %     for j = i:i + 24;  
% %         x = char(strcat('NewResult\', fileNames(j)));
% %     I = im2double(imread(x));
% %     [m,n,~]=size(I);
% %    I=imresize(I,[400,600]);
% 
% %     input{j-i+1} = I;
%     end
inputNum = count;
enhancedImage = fusionMain2(input,inputNum,k,skyweight,iniI,H,W,T,I); %model=0---/sum归一化    model=1--[0,1]归一化
%imshow(enhancedImage);
%enhancedImage=imresize(enhancedImage,[m,n]);
% imwrite(enhancedImage,['NewFusion2\' char(fileNames(j)) '.bmp']);
% i = j+1;
%     for k =1:25;
%     imwrite(Iweight{k},['fusionImage\HSV\weight\' char(fileNames(j-25+k)) '.bmp']);
%     end
%  if i==3+25*1;
%      break;
%  end
% end

end