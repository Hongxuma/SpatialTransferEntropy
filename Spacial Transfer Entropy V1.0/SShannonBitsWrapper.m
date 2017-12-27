function [HXt, HYw, HYf, HXtYw, HXtYf, HYwYf, HXtYwYf, I, T, nCounts] ...
    = SShannonBitsWrapper(classifiedData, nTuples, nBinMat, nYw, NoDataCode)

[~,nSignals] = size(classifiedData);
classifiedData(classifiedData == NoDataCode) = NaN;

HXt             = NaN(1,1);
HYw             = NaN(1,1);
HYf             = NaN(1,1);
HXtYw           = NaN(1,1);
HXtYf           = NaN(1,1);
HYwYf           = NaN(1,1);
HXtYwYf         = NaN(1,1);
I               = NaN(1,1);
T               = NaN(1,1);
nCounts         = NaN(1,1);



        

%         tupleMat=NaN(nTuples,3);
        tupleMat=classifiedData;


        %CHECK TO ENSURE TUPLEMAT HAS AT LEAST ONE COMPLETE ROW OF DATA
        if sum(sum(isnan(tupleMat),2) > 0) == nTuples
            logwrite(['Warning: no data in tupleMat, skipping sX = ' num2str(sX) ', sY = ' num2str(sY) ', lag = ' num2str(lag)],1)
            
        end
 
        %CALCULATE ENTROPIES FROM TUPLEMAT
        [C, nCounts(1,1)] = SgetCountMat( tupleMat, nBinMat, 1, 1, NaN);
        [HXt(1,1),HYw(1,1),HYf(1,1),HXtYw(1,1),HXtYf(1,1),HYwYf(1,1),HXtYwYf(1,1)]=SGetShannonBits( C, nCounts(1,1) );
        I(1,1) = HXt(1,1) + HYf(1,1) - HXtYf(1,1);
        T(1,1) = HXtYw(1,1) + HYwYf(1,1) - HYw(1,1) - HXtYwYf(1,1);



% for sX=1:nSignals
%     for sY=1:nSignals
%         
%         %CONSTRUCT THREE-COLUMN MATRIX WITH COLUMNS TIME-SHIFTED
%         XtSTART = max([lagRange(2) nYw])+1-lag;
%         YwSTART = max([lagRange(2) nYw])+1-nYw;
%         YfSTART = max([lagRange(2) nYw])+1; 
% 
%         tupleMat=NaN(nTuples,3);
%         tupleMat(:,1)=classifiedData(XtSTART:XtSTART+nTuples-1,sX);        %Leading Node Xt (lag tau earlier than present)
%         tupleMat(:,2)=classifiedData(YwSTART:YwSTART+nTuples-1,sY);        %Led Node Yw (present time)
%         tupleMat(:,3)=classifiedData(YfSTART:YfSTART+nTuples-1,sY);        %Led Node Yf (one timestep in future)
% 
%         %CHECK TO ENSURE TUPLEMAT HAS AT LEAST ONE COMPLETE ROW OF DATA
%         if sum(sum(isnan(tupleMat),2) > 0) == nTuples
%             logwrite(['Warning: no data in tupleMat, skipping sX = ' num2str(sX) ', sY = ' num2str(sY) ', lag = ' num2str(lag)],1)
%             continue
%         end
%  
%         %CALCULATE ENTROPIES FROM TUPLEMAT
%         [C, nCounts(sX,sY)] = getCountMat( tupleMat, nBinMat, sX, sY, NaN);
%         [HXt(sX,sY),HYw(sX,sY),HYf(sX,sY),HXtYw(sX,sY),HXtYf(sX,sY),HYwYf(sX,sY),HXtYwYf(sX,sY)]=GetShannonBits( C, nCounts(sX,sY) );
%         I(sX,sY) = HXt(sX,sY) + HYf(sX,sY) - HXtYf(sX,sY);
%         T(sX,sY) = HXtYw(sX,sY) + HYwYf(sX,sY) - HYw(sX,sY) - HXtYwYf(sX,sY);
% 
%     end
% end