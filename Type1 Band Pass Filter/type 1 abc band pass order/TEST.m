clc;
warning('off');
global wp1 wp2 ws1 ws2 E C Q P;
N=19;
Dim=N;
NP=100;
FoodNumber=NP/2;
limit=50; 
maxCycle=5000; 
D_opt=(Dim+1)/2;
ub=ones(1,D_opt); 
lb=-ones(1,D_opt);
runtime=1;
ws1=0.38*pi;
ws2=0.73*pi;
wp1=0.4*pi;
wp2=0.7*pi;


M=(N+1)/2;
C=zeros(M,M);
Q=zeros(M,M);
E=zeros(M,M);
P = zeros(M,1);
tic;
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
    [hn(i,:),bestFitness(i,:),EP(i,:),ES(i,:)] = myABC(@camel,NP,FoodNumber,limit,maxCycle,D_opt,ub,lb,runtime);
    t(i,:)=toc   
    B1=[hn(i,1:M-1)/2 hn(i,M) fliplr(hn(i,1:M-1)/2)];
    zn(i,:)=B1./sum(B1);
    [H1z w1]=freqz(B1,1,256);
    h_db=20*log10((abs(H1z)+eps)/max(abs(H1z)));
    delta_w=pi/length(H1z);
    h1=abs(H1z);
    H1_As=0.0001;
%     for k=1:length(w1)
%         if w1(k)>wp && w1(k) <= ws+0.01
%             H1_As=[H1_As H1z(k)];
%         end;
%     end;
%    
%     As(i,:)=max(-20*log10(abs(H1_As(1,2:end))))
%     Rp(i,:)=-(min(h_db(1:wp/delta_w+1)))
    As=-round(max(h_db(ws2/delta_w+1:1:length(H1z))))
     Rp(i,:)=-(min(h_db(wp1/delta_w+1:1:wp2/delta_w+1))) 
end;
[fmin minindex]=min(bestFitness);
 resultabc=[bestFitness zn]; 
fvtool(zn(minindex,:),1)
 save result_abc.mat resultabc;
% save Fitness_abc.mat fitness_abc;