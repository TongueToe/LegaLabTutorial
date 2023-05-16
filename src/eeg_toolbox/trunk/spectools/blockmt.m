

function varargout = blockmt(X,NW,K)

%computes multitaper spectral estimate on the columns of a matrix, X.

% ----------- SVN REVISION INFO ------------------
% $URL$
% $Revision$
% $Date$
% $Author$
% ------------------------------------------------

% C. Kovach 2008

N = size(X,1);

if nargin < 3
    
    K = 2*NW-1;
    
end



DPS = repmat(dpss(N,NW,K),1,size(X,2));

DPS = cat(1,DPS,zeros(size(DPS)));

XX = kron(X,ones(1,K));
XX = cat(1,XX,zeros(size(XX)));

avmat = kron(eye(size(X,2)),ones(K,1));

FX = fft(DPS.*XX);

FX = FX(1:N,:);

if nargout == 1
    
    varargout{1} = abs(FX).^2*avmat;
    
else
    
    varargout{1} = FX;    
    varargout{1} = avmat;
    
end