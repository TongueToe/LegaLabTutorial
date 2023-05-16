

% Removes .svn folders from the matlab path to reduce clutter.

% ----------- SVN REVISION INFO ------------------
% $URL$
% $Revision$
% $Date$
% $Author$
% ------------------------------------------------

[pdp,pdf] = fileparts(which('pathdef'));
copyfile(which('pathdef'),fullfile(pdp,sprintf('%s_backup.m',pdf)));

pd = fopen(which('pathdef'),'r');
mpath = fread(pd,'uchar=>char')';
fclose(pd);

mpath2 = regexprep(mpath,'[^\n]*\.svn[^\n]*\n','');

pd =fopen(which('pathdef'),'w');
if pd <=0 
    error('Wasn''t able to open pathdef.m for writing. Privileges?')
end

fwrite(pd,mpath2);
fclose(pd)