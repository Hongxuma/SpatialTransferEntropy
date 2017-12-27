function [Tplus,Tminus,Tnet,TnetBinary]=DoProduction(T)

[nVars,~,nTaus,nFiles]=size(T);

Tplus=zeros(nVars,nTaus,nFiles);
Tminus=zeros(nVars,nTaus,nFiles);
TnetBinary=NaN(nVars,nVars,nTaus,nFiles);

for f = 1:nFiles
    for i=1:nVars
        for j=1:nVars
            for t=1:nTaus
                if ~isnan(T(i,j,t,f))
                    Tplus(i,t,f)=Tplus(i,t,f)+T(i,j,t,f);
                    Tminus(j,t,f)=Tminus(j,t,f)+T(i,j,t,f);
                end
            end
        end
    end
end
Tnet=Tplus-Tminus;

for f = 1:nFiles
    for t=1:nTaus
        SQRmat=T(:,:,t,f);
        TnetBinary(:,:,t,f)=SQRmat-SQRmat';
    end
end

end