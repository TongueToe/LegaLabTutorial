% ----------- SVN REVISION INFO ------------------
% $URL$
% $Revision$
% $Date$
% $Author$
% ------------------------------------------------

function cmap = rbhot(clip)

if nargin < 1
    clip = 1;
end

ht = hot(64);
ht = ht(1:end-clip,:);

cld = ht(:,[3 2 1]);

cmap = cat(1,flipud(cld),ht);
