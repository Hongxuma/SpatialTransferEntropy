function [C,nCounts]=SgetCountMat(tupleMat,nBinMat,sX,sY,NoDataCode)

%This function takes only classified signals, where the signal has already
%been re-classified as integer positives representing the "bin" or
%vocabulary character that each portion of the signal is classified as.
%This will also require information as to the size of the vocabulary used
%to classify the variables.

tupleMat(tupleMat == NoDataCode) = NaN;

tupleMat(isnan(sum(tupleMat,2)),:) = [];
nCounts = size(tupleMat,1);
C = accumarray(tupleMat,1,[nBinMat(sX) nBinMat(sY) nBinMat(sY)]);

