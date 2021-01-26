function x_b=cast_judge(r,g,b)
x=(r+g+b)./3;
x_b=sqrt((r-x).*(r-x)+(g-x).*(g-x)+(b-x).*(b-x))./3;