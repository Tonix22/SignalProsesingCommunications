function x = Qfunc(SNRatio)
%QFUNC Summary of this function goes here
%   Detailed explanation goes here
x=0.5*(1-erf((SNRatio/sqrt(2))));
end

