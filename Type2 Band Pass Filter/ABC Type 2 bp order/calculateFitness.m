function fFitness=calculateFitness(fObjV)
fFitness=zeros(size(fObjV));
ind=find(fObjV>=0);
fFitness(ind)=1./(fObjV(ind));
ind=find(fObjV<0);
fFitness(ind)=abs(fObjV(ind));
