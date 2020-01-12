function [GlobalParams,GlobalMins,EP,ES] = myABC(objfun,NP,FoodNumber,limit,maxCycle,D,ub,lb,runtime)
GlobalMins=zeros(1,runtime);
for r=1:runtime
    Range=repmat((ub-lb),[FoodNumber 1]);
    Lower=repmat(lb,[FoodNumber 1]);
    Foods=rand(FoodNumber,D).*Range +Lower;
    ObjVal=feval(objfun,Foods);
    Fitness=calculateFitness(ObjVal);
    trial=zeros(1,FoodNumber); %reset trial counters
    BestInd=find(ObjVal==min(ObjVal));
    BestInd=BestInd(end);
    GlobalMin=ObjVal(BestInd);
    GlobalParams=Foods(BestInd,:);
    iter=1;
    best=BestInd;
    while iter<=maxCycle
        for i=1:(FoodNumber)
            sol=Foods(i,:);
            Param2Change=fix(rand*D)+1;
            neighbour=fix(rand*(FoodNumber))+1;
            while(neighbour==i)
                neighbour=fix(rand*(FoodNumber))+1;
            end;
            sol(Param2Change)=Foods(i,Param2Change)+(Foods(i,Param2Change)-Foods(neighbour,Param2Change))*(rand-0.5)*2;
            ind=find(sol<lb);sol(ind)=lb(ind);ind=find(sol>ub);sol(ind)=ub(ind);
            [ObjValSol EP ES]=feval(objfun,sol);
            FitnessSol=calculateFitness(ObjValSol);
            if (FitnessSol>Fitness(i))
                Foods(i,:)=sol;
                Fitness(i)=FitnessSol;
                ObjVal(i)=ObjValSol;
                trial(i)=0;
            else
                trial(i)=trial(i)+1;
            end;
        end;
        prob=(0.99.*Fitness./max(Fitness))+0.01;
        i=1;
        t=0;
        while(t<FoodNumber)
            if(rand<prob(i))
                t=t+1;
                sol=Foods(i,:);
                Param2Change=fix(rand*D)+1;
                neighbour=fix(rand*(FoodNumber))+1;
                while(neighbour==i)
                    neighbour=fix(rand*(FoodNumber))+1;
                end;
                sol(Param2Change)=Foods(i,Param2Change)+(Foods(i,Param2Change)-Foods(neighbour,Param2Change))*(rand-0.5)*2;
                ind=find(sol<lb);sol(ind)=lb(ind);ind=find(sol>ub);sol(ind)=ub(ind);
                [ObjValSol EP ES]=feval(objfun,sol);
                FitnessSol=calculateFitness(ObjValSol);
                if (FitnessSol>Fitness(i))
                    Foods(i,:)=sol;
                    Fitness(i)=FitnessSol;
                    ObjVal(i)=ObjValSol;
                    trial(i)=0;
                else
                    trial(i)=trial(i)+1;
                end;
            end;
            i=i+1;
            if (i==(FoodNumber)+1)
                i=1;
            end;
        end; 
        ind=find(ObjVal==min(ObjVal));
        ind=ind(end);best=ind;
        if (ObjVal(ind)<GlobalMin)
            GlobalMin=ObjVal(ind);
            GlobalParams=Foods(ind,:);
        end
        %%%%%%%%%%%% SCOUT BEE PHASE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        ind=find(trial==max(trial));
        ind=ind(end);
        if (trial(ind)>limit)
            trial(ind)=0;
            sol=Foods(best,:)+rand*(Foods(best,:)-Foods(ind,:));
            [ObjValSol EP ES]=feval(objfun,sol);
            FitnessSol=calculateFitness(ObjValSol);
            Foods(ind,:)=sol;
            Fitness(ind)=FitnessSol;
            ObjVal(ind)=ObjValSol;
        end;
        iter=iter+1;
       %  if mod(iter,1000)==0
         %   fprintf(' Iteraion: %d, bestFitness: %d \n ',iter,GlobalMin);
       % end;
    end
    GlobalMins(r)=GlobalMin;
end