c= imread('BV093.tif');
d= imread('BV13.tif');


for i=1:16
 c(1,:)=[];
 d(1,:)=[];
end

for i =1:4178
    for j=1:3847
        c(i,j)=c(i,j)+25.113;
        if c(i,j)<-300
            c(i,j)=-9999;
        end
        if d(i,j)<-300
            d(i,j)=-9999;
        end
    end
end


a = importdata('topo09.mat');
b = importdata('topo13.mat');
topoC=importdata('topochange.mat');
vegt10=importdata('type6veg10.mat');
vegt11=importdata('type6veg11.mat');


for i=4179:4917
    a(4179,:)=[];
    b(4179,:)=[];
    topoC(4179,:)=[];
    vegt10(4179,:)=[];
    vegt11(4179,:)=[];
end
