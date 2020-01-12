function [c_anneal, EP, ES]=camel(x)
global wp1 wp2 E C Q P;
alpha=0.2;
for m=1:size(x,1)
    b=x(m,:)';
    ES(m)=b'*Q*b+b'*C*b;
    EP(m)=((wp2-wp1)/pi)-2*b'*P+b'*E*b;

    c_anneal(m)=alpha*EP(m)+(1-alpha)*ES(m);
end;