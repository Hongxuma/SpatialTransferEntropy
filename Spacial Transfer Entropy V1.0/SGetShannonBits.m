function [HXt,HYw,HYf,HXtYw,HXtYf,HYwYf,HXtYwYf] = SGetShannonBits(C,nCounts)

%Get Marginal and Joint Shannon Entropies in terms of bits (log 2), given probability matrices

pXtYwYf=(C+eps)/nCounts;
pXt=sum(sum(pXtYwYf,2),3); % Marginal PDFs
pYw=sum(sum(pXtYwYf,1),3);
pYf=sum(sum(pXtYwYf,1),2);
pXtYw=sum(pXtYwYf,3); % Joint PDFs
pXtYf=sum(pXtYwYf,2);
pYwYf=sum(pXtYwYf,1);

HXt=-sum(pXt.*log2(pXt)); % Shannon Entropies
HYw=-sum(pYw.*log2(pYw));
HYf=-sum(pYf.*log2(pYf));
HXtYw=-sum(sum(pXtYw.*log2(pXtYw))); % Joint Shannon Entropies
HXtYf=-sum(sum(pXtYf.*log2(pXtYf)));
HYwYf=-sum(sum(pYwYf.*log2(pYwYf)));
HXtYwYf=-sum(sum(sum(pXtYwYf.*log2(pXtYwYf)))); % Triple Shannon Entropy

