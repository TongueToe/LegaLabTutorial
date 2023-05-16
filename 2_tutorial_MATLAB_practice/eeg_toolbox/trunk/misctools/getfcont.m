
function fc = getfcont(fname)

% Simply returns the full contents of a text file as a string.

% ----------- SVN REVISION INFO ------------------
% $URL$
% $Revision$
% $Date$
% $Author$
% ------------------------------------------------

fname = deblank(fname);

if ~exist(fname,'file') 
    error( 'File %s does not appear to exist.',fname);
end


fid = fopen(fname,'r');

if fid < 0
    fname = [fname,'.m']; %See if file wasn't read because it's missing an extentions.
    fid = fopen(fname,'r');
    if ~exist(fname,'file')
        error( 'File %s does not appear to exist.',fname);
    elseif fid < 0
        error('There was an error while attempting to read %s.',fname)
    end    
end

fc = fread(fid,'*char')';

fclose(fid);

