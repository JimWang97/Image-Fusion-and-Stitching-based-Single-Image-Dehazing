function output=GamaCorrection(input,m,n,H,W)
I = rgb2lab(input);
        L = sum(sum(I(:,:,1))) / (H * W);
        if L <= 50
            gamma = m;
        else
            gamma = n;
        end
    
    I(:,:,1) = imadjust(I(:,:,1)./100, [0 1], [0 1], gamma) * 100;
    output = lab2rgb(I);