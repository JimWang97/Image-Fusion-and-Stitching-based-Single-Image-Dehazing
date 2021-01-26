function [Img,BIGSKYWEIGHT]=BIG(H,W,GamaI,sky)    
    lenth=H-16*floor(H/16)+17; 
   height=W-16*floor(W/16)+17;
   IImg=padarray(GamaI,[lenth height],'replicate');
   SSKYWEIGHT=padarray(sky,[lenth height],'replicate');
   Img=IImg(1+lenth:end,1+height:end,1:3);
   BIGSKYWEIGHT=SSKYWEIGHT(1+lenth:end,1+height:end);