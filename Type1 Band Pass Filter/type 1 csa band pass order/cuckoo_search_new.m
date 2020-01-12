function [bestnest,fmin,res]=cuckoo_search_new(n,nd)
if nargin<1
    n=20;% Number of nests (or different solutions)
end;
% fitnessmse=ones(1,2000);
% Discovery rate of alien eggs/solutions
pa=0.001;
% N_IterTotal=4000;
N_IterTotal=2000;
Lb=-1*ones(1,nd); 
Ub=1*ones(1,nd);
for i=1:n,
nest(i,:)=Lb+(Ub-Lb).*rand(size(Lb));
end

% Get the current best
fitness=10^10*ones(n,1);
[fmin,bestnest,nest,fitness]=get_best_nest(nest,nest,fitness);
N_iter=0;
for iter=1:N_IterTotal,
     new_nest=get_cuckoos(nest,bestnest,Lb,Ub);
     [fnew,best,nest,fitness]=get_best_nest(nest,new_nest,fitness);
     N_iter=N_iter+n; 
     new_nest=empty_nests(nest,Lb,Ub,pa);
     % Evaluate this set of solutions
     [fnew,best,nest,fitness]=get_best_nest(nest,new_nest,fitness);
     % Update the counter again
     N_iter=N_iter+n;
     % Find the best objective so far  
     if fnew<fmin
         fmin=fnew;
         bestnest=best;
     end
     % save fmin and best  in each iteration
%      fitnessmse(iter)=fmin;
     solution(:,iter)=best;
     res(iter)=fmin;
end %% End of iterations
disp(strcat('Total number of iterations=',num2str(N_iter)));

%% Get cuckoos by ramdom walk
function nest=get_cuckoos(nest,best,Lb,Ub)
n=size(nest,1);
beta=3/2;
sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
for j=1:n,
    s=nest(j,:);
    u=randn(size(s))*sigma;
    v=randn(size(s));
    step=u./abs(v).^(1/beta);       
    stepsize=0.03*step.*(s-best);
    s=s+stepsize.*randn(size(s));
   nest(j,:)=simplebounds(s,Lb,Ub);
end

%% Find the current best nest
function [fmin,best,nest,fitness]=get_best_nest(nest,newnest,fitness)
for j=1:size(nest,1),
    fnew=fobj(newnest(j,:));
    if fnew<=fitness(j),
       fitness(j)=fnew;
       nest(j,:)=newnest(j,:);
    end
end
% Find the current best
[fmin,K]=min(fitness) ;
best=nest(K,:);


%% Replace some nests by constructing new solutions/nests
function new_nest=empty_nests(nest,Lb,Ub,pa)
% A fraction of worse nests are discovered with a probability pa
n=size(nest,1);
% Discovered or not -- a status vector
K=rand(size(nest))>pa;
stepsize=rand*(nest(randperm(n),:)-nest(randperm(n),:));
new_nest=nest+stepsize.*K;
for j=1:size(new_nest,1)
    s=new_nest(j,:);
  new_nest(j,:)=simplebounds(s,Lb,Ub);  
end

% Application of simple constraints
function s=simplebounds(s,Lb,Ub)
  ns_tmp=s;
  I=ns_tmp<Lb;
  ns_tmp(I)=Lb(I);  
  J=ns_tmp>Ub;
  ns_tmp(J)=Ub(J);
  s=ns_tmp;
  
function z=fobj(u)
global N wp1 ws1 wp2 ws2 E C Q P fitness_csa;
alpha=0.67;
b=u';
ES=b'*Q*b+b'*C*b; 
EP=((wp2-wp1)/pi)-2*b'*P+b'*E*b;
z=alpha*EP+(1-alpha)*ES;