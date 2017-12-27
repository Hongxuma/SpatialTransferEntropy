function [E] = SentropyFunction(classifiedData,nBinMat,NoDataCode)

[nData,~] = size(classifiedData);
% [nLags,~] = size(lagVect); %nLags includes the zero lag which is first
% lagRange = [min(lagVect) max(lagVect)]; % 0 must be included somewhere in lagVect
nYw = 1; % the number of data points signifiying the previous history of Y. Hard-coded as 1 point previous for now, but code structured to make this an option in the future
nTuples = nData;

% INITIALIZE PARALLEL OUTPUTS OF THE SHANNON BIT FUNCTION
HXt                     = NaN(1,1);
HYw                     = NaN(1,1);
HYf                     = NaN(1,1);
HXtYw                   = NaN(1,1);
HXtYf                   = NaN(1,1);
HYwYf                   = NaN(1,1);
HXtYwYf                 = NaN(1,1);
I                       = NaN(1,1);
T                       = NaN(1,1);
nCounts                 = NaN(1,1);

% PARALLELIZE ON MULTIPLE TIME LAGS
                
    [   HXt(:,:), ...
        HYw(:,:), ...
        HYf(:,:), ...
        HXtYw(:,:), ...
        HXtYf(:,:), ...
        HYwYf(:,:), ...
        HXtYwYf(:,:), ...
        I(:,:), ...
        T(:,:), ...
        nCounts(:,:) ] ...
        = SShannonBitsWrapper...
        (classifiedData, ...
        nTuples, ...
        nBinMat, ...
        nYw, ...
        NoDataCode);
            


% ASSIGN ALL OUTPUT VARIABLES TO THE TRANSFER STRUCTURE "E"
E.HXt=HXt;
E.HYw=HYw;
E.HYf=HYf;
E.HXtYw=HXtYw;
E.HXtYf=HXtYf;
E.HYwYf=HYwYf;
E.HXtYwYf=HXtYwYf;
E.I=I;
E.T=T;
E.nCounts=nCounts;
E.relT = T/HYf;
E.relI = I/HYf;



