Density09=importdata('Spacial/Density/Density09.mat');
Density13=importdata('Spacial/Density/Density13.mat');
Topo09=importdata('Spacial/Density/Topo09.mat');
Topo13=importdata('Spacial/Density/Topo13.mat');
TopoChange  = zeros(4683,3847); 
for i = 1:4683
    for j = 1:3847
        if (Topo09(i,j)==-9999) || (Topo13(i,j)==-9999)
            TopoChange(i,j)=-9999;
        else
            TopoChange(i,j)=Topo13(i,j)-Topo09(i,j);         
        end
        
        if(Density09(i,j)~=-9999 && Density13(i,j)==-9999)
            Density13(i,j)=0;
        end
        
        if(Density13(i,j)~=-9999 && Density09(i,j)==-9999)
            Density09(i,j)=0;
        end
    end
end
a=sum(sum(Density09~=-9999,2));
b=sum(sum(Density13~=-9999,2));
[R1,C1]=find(Density09~=-9999);

for count=1:90099
    KKDensity09(count)=Density09(R1(count),C1(count));
    KKDensity13(count)=Density13(R1(count),C1(count));
    KKTopo09(count)=Topo09(R1(count),C1(count));
    KKTopo13(count)=Topo13(R1(count),C1(count));
    KKTopoChange(count)=TopoChange(R1(count),C1(count));
end
CDensity09=KKDensity09';
CDensity13=KKDensity13';
CTopo09=KKTopo09';
CTopo13=KKTopo13';
CTopoChange=KKTopoChange';
% 
% 
% CDensity09=reshape(Density09,4683*3847,1);
% CDensity13=reshape(Density13,4683*3847,1);
% CTopo09=reshape(Topo09,4683*3847,1);
% CTopo13=reshape(Topo13,4683*3847,1);
% CTopoChange=reshape(TopoChange,4683*3847,1);
% 


XT=CDensity09;
YT=CTopo09;
YT2=CTopo13;

nBins = 10;
nVars = 3;
binPctlRange = [0 100];
%   Test = [Cveg10,Ctopo09,Ctopo13];
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

        
        
        
