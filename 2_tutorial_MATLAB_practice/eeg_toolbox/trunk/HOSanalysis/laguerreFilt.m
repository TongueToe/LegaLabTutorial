function [Xfilt,structout] =laguerreFilt(X,ord,tau,fs)

% [Xfilt,str] =laguerreFilt(X,ord,alpha)
%Filter with laguerre polynomialynomials up to specified order.
%
% Inputs:
%
%    X     : Input signal
%    ord   : Polynomial order as scalar value.
%    tau   : Time decay parameter. 
% 
%    Alternatively, the 2nd argument can be a struct array with fields
%               .order ->  polynomial order
%               .tau   ->  time decay parameter
% 
%    If X is a scalar integer, then the impulse response to the given 
%    number of samples is returned.
%    
%    
%    
% Outputs:
%
%    Xfilt : Filtered X 
%    str   : Struct array with order, tau and filter coeffificients.
%    
% C. Kovach 2019

if nargin < 4 || isempty(fs)    
    fs = 1;
end

if nargin < 3 || isempty(tau)
    tau = 1./log(2)./fs;
end

if nargin < 2
    ord = 0;
end

if isstruct(ord)
    structin = ord;
else
    structin = struct('order',ord,'tau',tau,'fs',fs);
end

if isscalar(X) % If the input is a scalar value then return the impulse response to specified order.
    X = [1;zeros(X-1,1)];
end

Xfilt = zeros(size(X,1),length(ord));

for k = 1:length(structin)
    str = structin(k);
    
    alpha = exp(-1./str.tau/str.fs);
    rootsA = alpha;
    
    rootsB = [];
    
    As={};Bs={};
    clear filtcoefs
    for i = 0:str.order
        A = poly(rootsA);
        B = [0 sqrt(1-alpha.^2)*poly(rootsB)];
        Xfilt(:,i+1) = filter(B,A,X);
        rootsA(end+1)= alpha;
        rootsB(end+1) = 1/alpha;
        As{i+1}=A;
        Bs{i+1}=B;
        filtcoef(i+1).A=A;
        filtcoef(i+1).B=B;
        filtcoef(i+1).order=i;
    end
    
    str.filtcoefs=filtcoef;
    structout(k) = str; %#ok<*AGROW>
end


