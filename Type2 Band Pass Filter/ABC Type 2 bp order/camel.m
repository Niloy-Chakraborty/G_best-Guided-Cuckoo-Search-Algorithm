function [c_anneal EP ES]=camel(x)
global fitness_abc count wp1 wp2 E C Q P;
alpha=0.2;
for m=1:size(x,1)
    b=x(m,:)';
    count=count+1;
    ES(m)=b'*Q*b+b'*C*b;
    EP(m)=((wp2-wp1)/pi)-2*b'*P+b'*E*b;

    c_anneal(m)=alpha*EP(m)+(1-alpha)*ES(m);
%     if mod(count,10)==0
%        fitness_abc=[fitness_abc c_anneal(m)];
%     end;
end;