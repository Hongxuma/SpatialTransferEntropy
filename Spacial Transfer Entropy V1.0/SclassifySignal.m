function [classifiedMat] = SclassifySignal(sampleMat,binEdges,nBinMat,NoDataCode)

[nData,nSignals]=size(sampleMat); 
classifiedMat=NaN(nData,nSignals);

sampleMat(sampleMat == NoDataCode) = NaN;

for s = 1:nSignals
    smat = sampleMat(:,s);
    cmat = nBinMat(s)*ones(size(smat));
    for e = 1:nBinMat(s)
        
        % Find data in the variable falling within this bin
        ii = find(smat <= binEdges(s,e));
        cmat(ii) = e; % Assign classification
        smat(ii) = NaN; % remove these that were classified from further consideration
        
        % If this is the last bin (greatest values), assign values greater
        % than this bin edge to this bin
        if e == nBinMat(s)
            ii = find(smat > binEdges(s,e));
            cmat(ii) = e; % Assign classification
            smat(ii) = NaN; % remove these that were classified from further consideration
        end
        
    end
    
    % Now assign the classified mat for this variable to the master
    % variable
    classifiedMat(:,s,:) = cmat;
end
classifiedMat(isnan(sampleMat)) = NaN;


classifiedMat(isnan(classifiedMat)) = NoDataCode;