function A=calcBoxAirlight(input,r)
r=r*2;
[h,w,~]=size(input);
rh=floor(h/r);
rw=floor(w/r);
i = 1+floor(h/r);
R=1;
W=1;
while 1
    if i<=h
        j = 1+rw;
        W=1;
        while 1
        if j<=w
            patch = input( i-rh : min(i+rh,h) , j-rw : min(w,j+rw), : );
            A(R,W,:)=calcRowAirlight(patch);
            W=W+1;
        else
            break;
        end
        j=j+rw*2;
        end
    else
        break;
    end
    i=i+rh*2;
    R=R+1;
end