
function unversion(path)

% Remove .svn directories from a path and all subdirectories,
% making it unversioned.

% ----------- SVN REVISION INFO ------------------
% $URL$
% $Revision$
% $Date$
% $Author$
% ------------------------------------------------


pd = cd;
if nargin > 0
    cd(path);
end


d = dir;

d = d([d.isdir]);


for i = 1:length(d)
    switch d(i).name
        case '.svn'
            rmdir(d(i).name,'s')
        case {'.','..'}
            continue
        otherwise
        unversion(d(i).name)
    end
end

fprintf('\nScrubbed\n%s\n',cd)

cd(pd)
