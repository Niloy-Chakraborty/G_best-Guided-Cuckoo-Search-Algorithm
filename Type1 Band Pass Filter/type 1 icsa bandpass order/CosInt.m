function y = CosInt (A,wa,wb)
% Evaluate the integral
%  yI = 1/(pi) [Int(wa,wb) cos(A*w) dw } 
%     = 1/(pi*A) [sin(A*wb) -sin(A*wa)]

if A==0
    y=(1/pi)*(wb-wa);
else
    y = 1/(pi*A)*(sin(wb*A)-sin(wa*A));
end;