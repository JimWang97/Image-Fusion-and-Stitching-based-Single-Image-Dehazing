function ALight = GetALight(NoI)
    ALight8 = reshape(calcBoxAirlight(NoI,8),[1,64,3]);
    ALight4 = reshape(calcBoxAirlight(NoI,4),[1,16,3]);
    ALight2 = reshape(calcBoxAirlight(NoI,2),[1,4,3]);
    ALight1 = reshape(calcBoxAirlight(NoI,1),[1,1,3]);
    ALight = [ repmat(ALight1,1,64) repmat(ALight2,1,16) repmat(ALight4,1,4) ALight8];
