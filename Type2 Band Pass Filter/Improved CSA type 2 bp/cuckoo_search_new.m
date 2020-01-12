function [bestnest,fmin,res]=cuckoo_search_new(n,nd)
global N H n nd N_IterTotal;
% fitnessmse=ones(1,2000);
% Discovery rate of alien eggs/solutions
N_IterTotal=5000;
Lb=-1*ones(1,nd); 
Ub=1*ones(1,nd);
for i=1:n
    nest(i,:)=Lb+(Ub-Lb).*rand(size(Lb));
end;

% Get the current best
fitness=10^10*ones(1,n);
[fmin,bestnest,worst,nest,fitness]=get_best_nest(nest,nest,fitness);
N_iter=0;flag=0;
for iter=1:N_IterTotal
      pa=1/nd;
     new_nest=get_cuckoos(nest,bestnest,worst,iter,fmin,fitness);
     [fnew,best,worst,nest,fitness]=get_best_nest(nest,new_nest,fitness);
     N_iter=N_iter+n; 
     new_nest=empty_nests(nest,best,Lb,Ub,pa);
     [fnew,best,worst,nest,fitness]=get_best_nest(nest,new_nest,fitness);
     N_iter=N_iter+n;
     if fnew<fmin
         fmin=fnew;
         bestnest=best;
     end;   
     solution(:,iter)=best;
     res(iter)=fmin;
end; %% End of iterations
disp(strcat('Total number of iterations=',num2str(N_iter)));

%% Get cuckoos by ramdom walk
function nest=get_cuckoos(nest,best,worst,iter,fmin,fitness)
global n nd N_IterTotal;
beta_max=1.5;beta_min=0.1;
beta=(beta_max-beta_min)*((N_IterTotal-iter)/N_IterTotal)+beta_min;
sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
best_rep=repmat(best,n,1);
u=randn(n,nd)*sigma;
v=randn(n,nd);
step=u./abs(v).^(1/beta);
% stepsize=alpha*step.*(nest-best_rep)+(1-alpha)*step.*(nest-repmat(worst,n,1));
stepsize=step.*(nest-best_rep)/iter;
nest=nest+stepsize.*randn(size(nest));
%  nest=best_rep+stepsize.*randn(size(nest));


%% Find the current best nest
function [fmin,best,worst,nest,fitness]=get_best_nest(nest,newnest,fitness)
global n nd;
fnew=fobj(newnest);
ind=find(fnew<fitness);
fitness(ind)=fnew(ind);
nest(ind,:)=newnest(ind,:);
[fmin,K]=min(fitness) ;
best=nest(K,:);
[fmax,K]=max(fitness) ;
worst=nest(K,:);
%% Replace some nests by constructing new solutions/nests

function new_nest=empty_nests(nest,best,Lb,Ub,pa)
n=size(nest,1);
best_rep=repmat(best,n,1);
K=rand(size(nest))>pa;
stepsize=rand*(best_rep(randperm(n),:)-nest(randperm(n),:));
% stepsize=rand*(nest(randperm(n),:)-nest(randperm(n),:));
new_nest=nest+stepsize.*K;

function z=fobj(u)
global count fitness_csa E ws1 ws2 wp1 wp2 N wp ws C Q P;
alpha=0.3;
for i=1:size(u,1)
    b=u(i,:)';
    count=count+1;
    ES=b'*Q*b+b'*C*b;
    EP=((wp2-wp1)/pi)-2*b'*P+b'*E*b;

    z(:,i)=alpha*EP+(1-alpha)*ES;
%     if mod(count,10)==0
%         fitness_csa=[fitness_csa z];
%     end
end;

