function [Surrogates] = ScreateSurrogates(Data,nsur)
% Create the surrogate data for statistical testing
% 
% ----------- Inputs -----------
% opts...
%
% ---------- Outputs -----------
% Surrogates = the surrogate data
%
% ------------------------------

Surrogates = NaN(size(Data,1),size(Data,2),nsur);

    % Randomly shuffle data (leaving NaNs where they are)
    for i = 1:size(Data,2)
        ni = ~isnan(Data(:,i));
        for ti = 1:nsur
            Surrogates(ni,i,ti) = randsample(Data(ni,i),sum(ni));
        end
    end
