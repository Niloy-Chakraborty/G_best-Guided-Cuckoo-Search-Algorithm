clc;
warning('off');
global count fitness_csa ws1 ws2 wp1 wp2 E N wp ws C Q P;
count=0;
fitness_csa=10;
dim =40; 
NP=100;

wp1=0.15*pi;
wp2=0.4*pi;
ws1=0.1*pi;
ws2=0.45*pi;
N=dim;
M=N/2;
C=zeros(M,M);
Q=zeros(M,M);
P = zeros(M,1);
E=zeros(M,M);
for m=0:M-1
    A=(N-1)/2-m;
    for n=0:M-1
        p=m-n;
        q=m+n;
        C(m+1,n+1)=ExpInt(p,q,N,ws2,pi);
        Q(m+1,n+1)=ExpInt(p,q,N,0,ws1);
        E(m+1,n+1)=ExpInt(p,q,N,wp1,wp2);
    end;
    P(m+1,1)=CosInt(A,wp1,wp2);
end;

for i=1:1
    tic;
    [x,bestFitness,res]=cuckoo_search_new(NP,dim/2);
    t(i,:)=toc
    z_n=[x fliplr(x)]/2;
    B1=z_n/sum(z_n);
    L=length(B1);
    [H1z w1]=freqz(B1,1,256);
    h_db=20*log10((abs(H1z)+eps)/max(abs(H1z)));
    delta_w=2*pi/length(H1z);
   
    
    
    h1=abs(H1z);
    H1_As=0.0001;
%     for k=1:length(w1)
%         if w1(k) >= ws
%             H1_As=[H1_As H1z(k)];
%         end;
%     end;
%     As(i,:)=min(-20*log10(abs(H1_As)))
%   % As=-round(max(h_db(ws/delta_w+1:1:length(h_fr))))
%     Rp(i,:)=-(min(h_db(1:wp/delta_w+1)))
%    
% end;
As=-round(max(h_db(ws2/delta_w+1:1:length(H1z))))
     Rp(i,:)=-(min(h_db(wp1/delta_w+1:1:wp2/delta_w+1))) 
end;

fvtool(z_n,1);
% [fmin minindex]=min(bestFitness);
%  resultabc=[bestFitness zn]; 
% fvtool(zn(minindex,:),1)
% save result_abc.mat resultabc;
% save Fitness_abc.mat fitness_abc;