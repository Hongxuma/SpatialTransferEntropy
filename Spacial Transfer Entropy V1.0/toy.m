clear;
topo = rand(500,500);
topo = topo+rand(500,500);
topo = topo+rand(500,500);
topo = topo+rand(500,500);

r1 = topo-2;
r2 = r1*10;

veg = rand(500,500)+rand(500,500)+rand(500,500)+rand(500,500)+rand(500,500);
veg = veg/5;
veg1 = fix((veg)*10);
veg2 = (rand(500,500)+rand(500,500)+rand(500,500)+rand(500,500)+rand(500,500))*2;
count = 0;

for i = 1:100
    for j = 1:100
        
        if r2(i,j)>0 
            veg2(i,j) = veg1(i,j)+fix(rand()*2);
            count=count+1;
        end
        if r2(i,j)<0 
            veg2(i,j) = veg1(i,j)-fix(rand()*2);
            count=count+1;
        end
            
        
    end
end
% introduce some noice

 C1 = reshape (r2,250000,1);
 C2 = reshape (veg1,250000,1);
 C3 = reshape(veg2,250000,1);
inputmat = [C1 C2 C3];








nBins = 15;
nVars = 3;
binPctlRange = [0 100];
%  Test = [Ctopo,Cveg10,Cveg11];

Test = inputmat;
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