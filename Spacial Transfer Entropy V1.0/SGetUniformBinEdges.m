function [binEdges,minEdge,maxEdge]=SGetUniformBinEdges(sampleMat,nBinMat,pctlRange,NoDataCode)

[~,nSignals]=size(sampleMat);
binMax=max(nBinMat);
binEdges=NaN(nSignals,binMax);
minEdge=NaN(nSignals);
maxEdge=NaN(nSignals);


%make nodata entries NaN, because min and max function ignores them...
sampleMat(sampleMat == NoDataCode) = NaN;

%compute the bin edges using fractions of the min and max
for s=1:nSignals
        % Use uniform bin width
        minEdge(s)=prctile(sampleMat(:,s),pctlRange(1));
        maxEdge(s)=prctile(sampleMat(:,s),pctlRange(end));
        E = linspace(minEdge(s,1),maxEdge(s,1),binMax+1); % all edges, including start
        binEdges(s,1:binMax)= E(2:binMax+1);
end