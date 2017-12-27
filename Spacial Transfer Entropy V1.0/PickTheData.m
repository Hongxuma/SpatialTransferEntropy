%  pick topo data from vegetype
topo09 = importdata('Spacial/BioTopoType/BTTTopo09.mat');
topo13 = importdata('Spacial/BioTopoType/BTTTopo13.mat');
topochange = importdata('Spacial/BioTopoType/BTTTopoChange.mat');
bv09=importdata('Spacial/BioTopoType/BTTBV09.mat');
bv13=importdata('Spacial/BioTopoType/BTTBV13.mat');

%pick BV data from vegetype
veg10 = importdata('Spacial/BioTopoType/BTTVegType10.mat');
veg11 = importdata('Spacial/BioTopoType/BTTVegType11.mat');
[a,b]=size(topo09);

vegetype = 6;

% %veg 2010
% topo09(veg10~=vegetype)=-9999;
% topo13(veg10~=vegetype)=-9999;
% topochange(veg10~=vegetype)=-9999;
% bv09(veg10~=vegetype)=-9999;
% bv13(veg10~=vegetype)=-9999;
% 
% out='Spacial/BioTopoType/';
% 
% fname09 = ['VegeType' num2str(vegetype) '_in 2010_ Topo09'];
% save([out fname09],'topo09');
% fname13 = ['VegeType' num2str(vegetype) '_in 2010_ Topo13'];
% save([out fname13],'topo13');
% fnamechange = ['VegeType' num2str(vegetype) '_in 2010_ Topochange'];
% save([out fnamechange],'topochange');
% fnamebv09 = ['VegeType' num2str(vegetype) '_in 2010_ BV09'];
% save([out fnamebv09],'bv09');
% fnamebv13 = ['VegeType' num2str(vegetype) '_in 2010_ BV13'];
% save([out fnamebv13],'bv13');

%veg 2011
topo09(veg11~=vegetype)=-9999;
topo13(veg11~=vegetype)=-9999;
topochange(veg11~=vegetype)=-9999;
bv09(veg11~=vegetype)=-9999;
bv13(veg11~=vegetype)=-9999;

out='Spacial/BioTopoType/';

fname09 = ['VegeType' num2str(vegetype) '_in 2011_ Topo09'];
save([out fname09],'topo09');
fname13 = ['VegeType' num2str(vegetype) '_in 2011_ Topo13'];
save([out fname13],'topo13');
fnamechange = ['VegeType' num2str(vegetype) '_in 2011_ Topochange'];
save([out fnamechange],'topochange');
fnamebv09 = ['VegeType' num2str(vegetype) '_in 2011_ BV09'];
save([out fnamebv09],'bv09');
fnamebv13 = ['VegeType' num2str(vegetype) '_in 2011_ BV13'];
save([out fnamebv13],'bv13');