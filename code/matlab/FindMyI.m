function RepresentativeT=FindMyI(D,sky)
    D(sky>=0.6)=NaN;
    kk=isnan(D);
    KK=sum(sum(kk));
    DC=findidd(D,KK);
    RepresentativeT=QuitI(DC);
