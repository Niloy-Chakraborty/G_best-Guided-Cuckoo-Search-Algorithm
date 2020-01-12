function y = ExpInt (p,q,N,wa,wb)
% Evaluate the integral
%  yI = 1/(2 pi) [Int(wa,wb) exp(-j w k) dw 
%              +  Int(-wb,-wa) exp(-j w k) dw]
%     = 1/(-j 2 pi k) [exp(-j wb k) - exp(-j wa k)
%                      + exp(j wa k) - exp(j wb k)]
%     = 1/(pi k) [sin(wb k) - sin(wa k)]

if (p == 0)
  y1 = (wb - wa) / (2*pi);
else
  y1 = 1/(2*pi*p) * (sin(wb*p) - sin(wa*p));
end
if (q == N-1)
  y2 = (wb - wa) / (2*pi);
else
  y2 = 1/(2*pi*(q-N+1)) * (sin(wb*(q-N+1)) - sin(wa*(q-N+1)));
end
y=y1+y2;