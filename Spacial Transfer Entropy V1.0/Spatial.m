%this is the first version of spatial transfer entropy
%we seperate research region into several small cells
%eacch time, we only calculate the information flow between variables
%within this small cell.
%However, we still could have statistical meaningful result in the big
%picture




%input the raster or 2D matrix data here
%the data should have same size
%every cell in different matrix with same row and column should describe
%the same region.
topo09=importdata('BioTopoType/VegeType4_in 2010_ Topo09.mat');
topo13=importdata('BioTopoType/VegeType4_in 2010_ Topo13.mat');
topochange=topo13-topo09;
bv09=importdata('BioTopoType/VegeType4_in 2010_ BV09.mat');
bv13=importdata('BioTopoType/VegeType4_in 2010_ BV13.mat');

%reshape the data into a column. 
Ctopo09 = reshape(topo09,4178*3847,1);
Ctopo13 = reshape(topo13,4178*3847,1);
Cbv09 = reshape(bv09,4178*3847,1);
Cbv13 = reshape(bv13,4178*3847,1);
Ctopochange = reshape(topochange,4178*3847,1);



XT=Cbv09;
YT=Ctopo09;
YT2=Ctopo13;

nBins = 10;
nVars = 3;
binPctlRange = [0 100];

Test = [XT,YT,YT2];

 TestData = Test;
 Data = SpreProcess(TestData);
 oneTailZ = 1.66;


 R = SintializeOutput(nBins,nVars);
 
[R.binEdgesLocal(:,:),R.minEdgeLocal(:),R.maxEdgeLocal(:)] = SGetUniformBinEdges(Data,R.nBinVect,binPctlRange,NaN);
[Data]=SclassifySignal(Data,R.binEdgesLocal(:,:),R.nBinVect,NaN);
[E] = SentropyFunction(Data,R.nBinVect,NaN);

nTests = 200;
        shuffT = NaN(nTests,1);
        shuffI = NaN(nTests,1);
        shuffHYf = NaN(nTests,1); 

        
        for si = 1:nTests

            Surrogates = ScreateSurrogates(TestData,1);

            
            % Preprocess surrogates same as Data
            Surrogates = SpreProcess(Surrogates);
            
            % Collect stats on Surrogates
            [SbinEdgesLocal,minEdgeLocal,maxEdgeLocal] = SGetUniformBinEdges(Surrogates,R.nBinVect,binPctlRange,NaN);
            R.minSurrEdgeLocal = nanmin([minEdgeLocal R.minSurrEdgeLocal],[],2);
            R.maxSurrEdgeLocal = nanmax([maxEdgeLocal R.maxSurrEdgeLocal],[],2);
            
            % If we are doing local binning or data is already binned, we can 
            % go straight into classification and/or entropy calculations. 


                % Classify the data with local binning

            [Surrogates]=SclassifySignal(Surrogates,R.binEdgesLocal,R.nBinVect,NaN);


               
                
                % Run entropy function
                    

                    [K] = SentropyFunction(Surrogates,R.nBinVect,NaN);
                    

                        % All lags tested
                        shuffT(si) = K.T;
                        shuffI(si) = K.I;
                        shuffHYf(si) = K.HYf;


         end


        
        % Calculate stats for statistical significance
        
        R.meanShuffT=mean(shuffT);
        R.sigmaShuffT=std(shuffT);
        R.meanShuffI=mean(shuffI);
        R.sigmaShuffI=std(shuffI);
        R.meanShuffTR=mean(shuffT./shuffHYf);
        R.sigmaShuffTR=std(shuffT./shuffHYf);
        R.meanShuffIR=mean(shuffI./shuffHYf);
        R.sigmaShuffIR=std(shuffI./shuffHYf);
        
        R.SigThreshT = R.meanShuffT+oneTailZ*R.sigmaShuffT;
        R.SigThreshI = R.meanShuffI+oneTailZ*R.sigmaShuffI;
        R.SigThreshTR = R.meanShuffTR+oneTailZ*R.sigmaShuffTR;
        R.SigThreshIR = R.meanShuffIR+oneTailZ*R.sigmaShuffIR;

        TT = E.T-R.SigThreshT
        II = E.I-R.SigThreshI
        TZ = E.T/E.I
        TRT = E.relT-R.SigThreshTR
        IRI = E.relI-R.SigThreshIR

        
        
        
