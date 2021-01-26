function darkchannel = calcDarkChannel(input,r)
[h, w, ~] = size(input);
%zeros(height, width);
%radius = 5;%round(min(height, width) * 0.02);
pixeldc = min(input, [], 3);
darkchannel = pixeldc;
for i = 1:h
   for j = 1:w
      patch = pixeldc(max(1,i-r):min(i+r,h),max(1,j-r):min(w,j+r));
      darkchannel(i, j) = min(min(patch));
   end
end

imshow(darkchannel);
end
