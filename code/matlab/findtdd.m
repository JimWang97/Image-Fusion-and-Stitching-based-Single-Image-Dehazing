function T=findtdd(darkchannelOri,KK) 
darkchannelOri=round(darkchannelOri*255);
     for k=0:255
        delta=0;count=0;
        for m=max(0,k-20):min(255,k+20)
             b=darkchannelOri==m;
             n=sum(b(:));
             d=1/(exp(abs(k-m)));
             delta=n*d+delta;
             count=count+1;
        end
        p(k+1,1)=delta;
        p(k+1,2)=k;
     end
    dist=p(:,2);
    P=p(:,1);
    [~,I]=max(p(:,1));
    T(2,1)=p(I,2)/255;
    T(1,1)=P(I);
    D=p(I,2);
    DIST=abs(dist-D);
    Count=2;
    while 1
    date=DIST.*P;
    [~,I]=max(date);
    T(2,Count)=p(I,2)/255;
    T(1,Count)=P(I);
    D=p(I,2);
    Dist=abs(dist-D);
    DIST=min(DIST(:,1),Dist(:,1));
    Count=Count+1;
    h=(DIST<=0.039);
    S=0;
    for i=1:256
        if h(i,1)==0
            d=darkchannelOri==dist(i);
            s=sum(d);
            S=s+S;
        end
    end
    if S<=0.001*KK
        break;
    end
    if Count>=150
        break;
    end
    end
    