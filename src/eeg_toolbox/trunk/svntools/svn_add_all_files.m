function svn_add_all_files(ext)

%
%
%    svn_add_all_files( ext )
%
%  Adds all files of type ext (default '.m') to the repository.
%
%  For m-files revision data is also inserted after the first block of
%  comments.
%
% See also insert_svn_revision_data Add_this_to_matlab_scripts_for_revision_data.readme
%
%


%  C Kovach 2011
%
% ----------- SVN REVISION INFO ------------------
% $URL$     
% $Revision$
% $Date$
% $Author$
% ------------------------------------------------
%

if nargin < 1 || isempty(ext)
     ext = 'm';
end

[a,b,c] = fileparts(ext);

if ~isempty(a)
    ext = fullfile(a,[b,c]);
elseif isempty(c)
    ext = ['*.',b];
    c = ['.',b];
end


com = sprintf('svn add %s',ext);

system(com);

if isequal(c,'.m')
    svn_insert_revision_data;
end




