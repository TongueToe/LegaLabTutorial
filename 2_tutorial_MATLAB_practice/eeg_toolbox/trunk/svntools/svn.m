function varargout = svn(varargin)

%
% Pass svn commands to the system. This is equivalent to !svn ...
%

% ----------- SVN REVISION INFO ------------------
% $URL$
% $Revision$
% $Date$
% $Author$
% ------------------------------------------------

com = ['svn ',sprintf('%s ',varargin{:})];

[stat,res] = system(com);
fprintf(res)
if nargout > 0
    varargout{1} = stat;
end
if nargout > 1 
    varargout{2} = res;
end

