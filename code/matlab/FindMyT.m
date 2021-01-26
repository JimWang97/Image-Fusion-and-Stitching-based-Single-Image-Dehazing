function RepresentativeT=FindMyT(D,sky)
    D(sky>=0.6)=NaN;
    kk=isnan(D);
    KK=sum(sum(kk));
    DC=findtdd(D,KK);
    RepresentativeT=QuitT(DC);
