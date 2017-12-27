function [R] = SintializeOutput(nBins,nVars)
nBins = nBins'; % Make column vector




% INITIALIZE PREPROCESSING QUANTITIES
% R.nRawData               = zeros(nDataFiles,1);
% R.nVars                  = zeros(nDataFiles,1);
% R.varNames               = opts.varNames;
% R.varSymbols             = opts.varSymbols;
% R.varUnits               = opts.varUnits;
if length(nBins) < nVars
    R.nBinVect           = ones(nVars,1)*nBins;
else
    R.nBinVect           = nBins;
end
% R.nClassified            = NaN(nDataFiles,1);
R.binEdgesLocal          = NaN(nVars,max(nBins));
R.minEdgeLocal           = NaN(nVars);
R.maxEdgeLocal           = NaN(nVars);
R.minSurrEdgeLocal       = NaN(nVars);
R.maxSurrEdgeLocal       = NaN(nVars);
R.LocalVarAvg            = NaN(nVars);
R.LocalVarCnt            = NaN(nVars);
R.binEdgesGlobal         = NaN(nVars,max(nBins));
R.minEdgeGlobal          = NaN(nVars,1);
R.maxEdgeGlobal          = NaN(nVars,1);
R.binSurrEdgesGlobal     = NaN(nVars,max(nBins));
R.minSurrEdgeGlobal      = NaN(nVars,1);
R.maxSurrEdgeGlobal      = NaN(nVars,1);
R.GlobalVarAvg           = NaN(nVars,1);

% INITIALIZE OUTPUT QUANTITIES FROM THE ENTROPYFUNCTION
% R.lagVect                = opts.lagVect;
R.HXt                    = NaN(nVars,nVars);
R.HYw                    = NaN(nVars,nVars);
R.HYf                    = NaN(nVars,nVars);
R.HXtYw                  = NaN(nVars,nVars);
R.HXtYf                  = NaN(nVars,nVars);
R.HYwYf                  = NaN(nVars,nVars);
R.HXtYwYf                = NaN(nVars,nVars);
R.SigThreshT             = NaN(nVars,nVars);
R.SigThreshI             = NaN(nVars,nVars);
R.meanShuffT             = NaN(nVars,nVars);
R.sigmaShuffT            = NaN(nVars,nVars);
R.meanShuffI             = NaN(nVars,nVars);
R.sigmaShuffI            = NaN(nVars,nVars);
R.nCounts                = NaN(nVars,nVars);
R.I                      = NaN(nVars,nVars);
R.T                      = NaN(nVars,nVars);
R.IR                     = NaN(nVars,nVars);
R.TR                     = NaN(nVars,nVars);
R.SigThreshTR            = NaN(nVars,nVars);
R.SigThreshIR            = NaN(nVars,nVars);
R.meanShuffTR            = NaN(nVars,nVars);
R.sigmaShuffTR           = NaN(nVars,nVars);
R.meanShuffIR            = NaN(nVars,nVars);
R.sigmaShuffIR           = NaN(nVars,nVars);
R.Tplus                  = NaN(nVars);
R.Tminus                 = NaN(nVars);
R.Tnet                   = NaN(nVars);
R.TnetBinary             = NaN(nVars,nVars);
R.InormByDist            = NaN(nVars,nVars);
R.TnormByDist            = NaN(nVars,nVars);
R.SigThreshInormByDist   = NaN(nVars,nVars);
R.SigThreshTnormByDist   = NaN(nVars,nVars);
R.Ic                     = NaN(nVars,nVars);
R.Tc                     = NaN(nVars,nVars);
R.TvsIzero               = NaN(nVars,nVars);
R.SigThreshTvsIzero      = NaN(nVars,nVars);
R.IvsIzero               = NaN(nVars,nVars);
R.SigThreshIvsIzero      = NaN(nVars,nVars);
R.Abinary                = NaN(nVars,nVars);
R.Awtd                   = NaN(nVars,nVars);
R.AwtdCut                = NaN(nVars,nVars);
R.charLagFirstPeak       = NaN(nVars,nVars);
R.TcharLagFirstPeak      = NaN(nVars,nVars);
R.charLagMaxPeak         = NaN(nVars,nVars);
R.TcharLagMaxPeak        = NaN(nVars,nVars);
R.TvsIzerocharLagMaxPeak = NaN(nVars,nVars);
R.nSigLags               = NaN(nVars,nVars);
R.FirstSigLag            = NaN(nVars,nVars);
R.LastSigLag             = NaN(nVars,nVars);
R.HXtNormByDist          = NaN(nVars,nVars);
