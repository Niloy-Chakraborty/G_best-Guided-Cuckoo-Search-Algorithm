clc;
warning('off');
global count fitness_csa R N wp1 ws1 wp2 ws2 C Q P E G;
count=0;
fitness_csa=10;
dim =61; 
NP=100;

ws1=0.38*pi;
ws2=0.73*pi;
wp1=0.4*pi;
wp2=0.7*pi;


N=dim;
M=(N+1)/2;
C=zeros(M,M);
Q=zeros(M,M);
P=zeros(M,M);
E=zeros(M,M);
G=zeros(M,M);
R=zeros(M,M);
P = zeros(M,1);
F=zeros(M,M);
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
    [x,bestFitness,res]=cuckoo_search_new(NP,(dim+1)/2);
    t(i,:)=toc
    z_n=[x(i,1:M-1)/2 x(i,M) fliplr(x(i,1:M-1))/2];
    B1=z_n/sum(z_n);
    L=length(B1);
    [H1z w1]=freqz(B1,1,256);
    h_db=20*log10((abs(H1z)+eps)/max(abs(H1z)));
    delta_w=pi/length(H1z);
   
    
    
    h1=abs(H1z);
     H1_As=0.0001;
%     for k=1:length(w1)
%         if w1(k) >= ws1 || w1(k)<=ws2
%             H1_As=[H1_As H1z(k)];
%         end;
%     end;
%     As(i,:)=min(-20*log10(abs(H1_As)))
   As=-round(max(h_db(ws2/delta_w+1:1:length(H1z))))
     Rp(i,:)=-(min(h_db(wp1/delta_w+1:1:wp2/delta_w+1))) 
   
end;

fvtool(z_n,1);

 [fmin minindex]=min(bestFitness);
 resulticsa=[bestFitness z_n]; 
% fvtool(z_n(minindex,:),1)
 save result_icsa.mat resulticsa;
% save Fitness_csa.mat fitness_csa;
