function outputwork(weight,H,W,input,i,NUM)
    HIPIC=zeros(H,W,3);
    [~,WInd]=max(weight,[],3);
    for num=1:NUM-1
        
        HIPIC(WInd==num)=input{1,num}(WInd==num);
        HIPIC(WInd==num +H*W )=input{1,num}(WInd==num + H*W);
        HIPIC(WInd==num +2*H*W )=input{1,num}(WInd==num + 2*H*W);
%         input{1,num}(WInd==num)=255;
        dir=['D:\matlabCode\NewAT\20180801\' num2str(i) '_Pic\'];
        WORD=['mkdir ' dir];
        system(WORD);
        str=[num2str(i)  '_0801_Num' num2str(num)  '_Pic' ];
        imwrite(input{1,num},[dir str '.bmp']);
        
        dir=['D:\matlabCode\NewAT\20180801\' num2str(i) '_Sco\'];
        WORD=['mkdir ' dir];
        system(WORD);
        str=[num2str(i)  '_0801_Num' num2str(num)  '_Sco' ];
        imwrite(uint8(weight(:,:,num)),[dir str '.bmp']);
    end
    dir=['D:\matlabCode\NewAT\20180801\output\'];
    WORD=['mkdir ' dir];
    system(WORD);
    imwrite(uint8(WInd),[dir num2str(i) '_label.bmp']);
    imwrite(HIPIC,[dir num2str(i) '_highestPic.bmp']);