function rotor(indx)

%Displays a rotating icon inside a loop
r = '|/-\';
% ----------- SVN REVISION INFO ------------------
% $URL$
% $Revision$
% $Date$
% $Author$
% ------------------------------------------------


if indx > 1
    fprintf('\b')
end

fprintf('%s',r(mod(indx,4)+1));

