function [plh,h] = errorshade(x,y,stderr,varargin)


resamp2 = 100;
plotse = 0:1:2;
dist = @(x)exp(-x.^2/2);
basecolor = [1 1 1];
if length(y)>resamp2
    resamp2 = size(y,1);
end

[a,b] = rat(size(y,1)/resamp2,.5);
se = resample(stderr,b,a);
xrs = x(round(1:b/a:end));
xpatch = [xrs;xrs(end:-1:1)];
ypatch = [-ones(size(xrs));ones(size(xrs))];

plh = plot(x,y,varargin{:}); 
hold on
plotse = sort(plotse,'descend');
for k = 1:length(plh)
    
    col = plh(k).Color;
    %ses = [plotse];
    w = dist((plotse([1, 1:end-1])+plotse)/2);
%    w = dist(plotse);
    yrs = resample(y,a,b);
    
    h = patch(xpatch(:,ones(1,length(plotse))),...
                [yrs;yrs(end:-1:1)]*ones(1,length(plotse)) + ([se(:,k);se(end:-1:1,k)].*ypatch)*plotse,...
                permute(col'*w + basecolor'*(1-w),[3 2 1]));
    h.EdgeColor = 'none';
end
