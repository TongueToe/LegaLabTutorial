% ----------- SVN REVISION INFO ------------------
% $URL$
% $Revision$
% $Date$
% $Author$
% ------------------------------------------------


function [facets,mnd] = projectcontact(C,bem,layers)

player = ismember(bem.layer,layers);

for i = 1:size(C,1)
    
    D = sqrt(sum((bem.FC - repmat(C(i,:),size(bem.FC,1),1)).^2,2));
    D(~player) = Inf; 
    [mnd(i),facets(i)] = min(D);
end
