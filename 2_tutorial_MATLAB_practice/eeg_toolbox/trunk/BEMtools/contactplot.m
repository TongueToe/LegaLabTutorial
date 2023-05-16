% ----------- SVN REVISION INFO ------------------
% $URL$
% $Revision$
% $Date$
% $Author$
% ------------------------------------------------

function pl = contactplot(COR,C,varargin)

hold on
for i = 1:size(COR,1)
    
    pl(i) = plot3(COR(i,1),COR(i,2),COR(i,3),varargin{:});
    
    set(pl(i),'color',cm2rgb(C(i)));
end


