function data = readncs(fnames,pth,varargin)

%
% Basic script to read continuous neuralynx data.
%
% Usage:
%
%   D = readncs([filename(s)],[file path])
%
% Without input arguments files are selected by UI menu.
%
% Output:
%
%   D:  Struct array with the following fields
%
%       D.dat : data in column vector as single
%       D.fs  : average sampling rate as determined from the time
%              stamps. This value appears to deviate slightly from the
%              nominal sampling rate reported in the header.
%       D.name : File name without extension
%       D.TimeStamp   : TimeStamps for each recording segment
%       D.ChannelNumber : Channel number for each recording segment
%       D.SampFreq : Sampling frequency recprded for each recording segment
%       D.NumValidSamples : Number of valid samples for each recording
%                          epoch
%       D.time_fmt  : Time format, default 'unix_usec' = unix time in microseconds
%       D.file      : File name with extension%       
%       D.missingSamples : A sparse vector of the boundaries of missing
%                          data. The onset of a gap is marked with +1 and
%                          the end of a gap is -1. Missing 
%                           samples are replaced with 0. Use 
%                               missingData = cumsum(D.missingSamples);
%                           to identify missing data. 
%       D.numberOfSamplesMissing : Total number of missing samples.
%
% See also READNLX and READNEV
%

%
% C Kovach 2017
%
%


params.header_bytes = 16384;
params.data_precision = 'int16';
% params.samphead_bytes=20;
params.samptime_precision='uint64';
params.samphead = struct('TimeStamp','uint64','ChannelNumber','uint32','SampFreq','uint32','NumValidSamples','uint32');
params.unitVscale= 1e6; % scale voltage by this amount (eg. 1e6 = microvolt )
params.native_sampling_rate = 16e3; % This is the assumed native sampling rate
                                    % of the recording system. As of Pegasus ver. 2.1.1, 
                                    % Neuralynx fails to record this rather
                                    % vital bit of infomration in the
                                    % header.
%%% This script checks the header data and applies the delay correction to 
%%% timestamps for data recorded with pegasus ver. < 2.0.1. Options are:
%%%     'correcting' - apply the correction with a warning. This is the
%%%                    recommended setting.
%%%     'warning'    - throw a warning without doing anything
%%%     'asking'     - stop and ask if the correction should be applied.
%%%     'shift'     -  correct by shifting the data so that samples align. This is not recommended.  
params.handle_pegasus_v201_bug_by = 'correct';
params.enforce_polarity = true; % Check if the InputInverted is true and invert sign if so.
params.headers_only = false; %Don't load the actual data if true
persistent path warned warned2

i = 1;
while i <length(varargin)
   if ismember(lower(varargin{i}),fieldnames(params))
       params.(varargin{i})=varargin{i+1};
   else
       error('%s is not a recognized keywork',varargin{i})
   end
   i=i+2;
end

if nargin < 2
    pth = '';
end


% if nargin > 0 
%     [pth2,fnames] = fileparts(fn);
%     pth = fullfile(pth,pth2);
% end

if ~isempty(pth)
    path = pth;
end


if nargin < 1 || isempty(fnames)
    
    [fnames,pth] = uigetfile({'*.ncs','NCS files';'*.*','All files'},'Select NLX data file',path,'multiselect','on');
    if isnumeric(fnames)
        return
    else
        path = pth;
    end
    
    if ~iscell(fnames)
        fnames = {fnames};
    end
    
    % sort numerically
    decell= @(x)[x{:}];
    reg = regexp(fnames,'(\d+)_?(\d*)','tokens','once');
    reg = cat(1,reg{:});
    chn = fliplr(arrayfun(@(x)str2num(decell(x)),reg(:,1))); %#ok<*ST2NM>
    [~,srti] = sortrows(chn);
    fnames = fnames(srti);
else

    if ~iscell(fnames)
        fnames = {fnames};
    end
end
%Valid fieldname characters
fnchars ='abcdefghijklmnopqrstuvwxyz1234567890_';
fnchars = unique([fnchars,upper(fnchars)]);

data = struct('dat',[],'fs',[],'name','','units','','header',[]);

%parse sample header
sampheadfn = fieldnames(params.samphead);

for k = 1:length(sampheadfn)
    sampheadbyteN(k) =  cellfun(@str2double,regexp(params.samphead.(sampheadfn{k}),'(\d+)','tokens','once'))/8; %#ok<*AGROW>
end
params.samphead_bytes = sum(sampheadbyteN);

delay_correction = 0;

bug_version_range = [2 1 0; 2 1 1]; %First row is 1st version affected and 2nd row is first version fixed
bverns = bug_version_range*(2.^(8*(2:-1:0)))';
for k = 1:length(fnames)
  
    [pth,fn,ext] = fileparts(fnames{k});
    if ~isempty(pth)
        path=pth;
    end
    fn = fullfile(path,[fn,ext]);
    fid = fopen(fn);
    txt = fread(fid,16384,'uchar=>char')';
    txt = regexprep(txt,char(181),'u');
    flds = regexp(txt,'-([^\s]*)\s*([^\n]*)','tokens');
    flds = cat(1,flds{:})';
    flds(1,:) = cellfun(@(x)x(ismember(x,fnchars)),flds(1,:),'uniformoutput',false);
    flds(2,:) = cellfun(@(x)deblank(x),flds(2,:),'uniformoutput',false);
        
    data(k).header = struct(flds{:});
    data(k).fs = str2double(data(k).header.SamplingFrequency);

    %%% Check version and correct bug
    re = regexp(data(k).header.ApplicationName,'Pegasus "([^"]*)','tokens','once');
    ver = cellfun(@str2double,regexp(re{1},'\d*','match'));
    vern = ver*2.^(8*((0:-1:-length(ver)+1)+2))';
    
    if vern>=bverns(1) && vern<bverns(2)
        
        if isfield(data(k).header,'SubsamplingBugFix')
            switch lower(data(k).header.SubsamplingBugFix)
                case {'true'}
                    if k ==1 && isempty(warned)
                        warning('These data were recorded with Pegasus version %s and may have been affected by a bug which results in erroneous DSP filter cutoffs and delays for subsampled data. According to information in the header, a correction has already been applied.',vstr)                   
                    end
                    params.handle_pegasus_v201_bug_by='ignore';

                    %                 case {'false'}
%                     warning('These data were recorded with Pegasus version %s and may have been affected by a bug which results in erroneous DSP filter cutoffs and delays for subsampled data. According to information in the header, a correction has already been applied.',vstr)                   
%                      params.handle_pegasus_v201_bug_by='ignore';
            end
        end
            
        vstr = re{1};
        
        switch params.handle_pegasus_v201_bug_by
            case {'warning','warn'}
                if k ==1 && isempty(warned)
                    warning('These data were recorded with Pegasus version %s and may be affected by a bug which results in erroneous DSP filter cutoffs and delays for subsampled data. With current settings, NO correction will be applied. Change the value of params.handle_pegasus_v201_bug_by in %s.m if that is not the desired behavior.',vstr,mfilename)                   
%                     warned = true;

                end
                do_correct = false;
            case {'correcting','correct','asking','ask','shift','shifting'}
                    do_correct = true;
                    shift_data=false;
                    switch params.handle_pegasus_v201_bug_by
                        case {'asking','ask'}
                            if k ==1
                                do_correct=strcmp(questdlg(sprintf('These data were recorded with Pegasus version %s and are likely affected by a bug in subsampling resulting in erroneous DSP filter cutoffs and delays. Should timing delay be corrected?',vstr)),'Yes');
                            end
                        case {'shifting','shift'}
                            shift_data = true;
                        otherwise
                            if k ==1 && isempty(warned)
                                 warning('These data were recorded with Pegasus version %s and are assumed to be affected by a bug which results in erroneous DSP filter cutoffs and delays for subsampled data. A correction will be applied.',vstr)
%                                  warned = true;
                            end
                    end
                
            case {'ignore','ignoring'}   
               do_correct = false;
           
            otherwise
                error(sprintf('params.handle_pegasus_v201_bug_by must be one of ''warning'',''correcting'' or ''asking''')) %#ok<*SPERR>
        end
        
        if do_correct && strcmp( data(k).header.DspDelayCompensation,'Enabled')
            if k ==1 && isempty(warned)
                warning('The subsampling bug fix assumes that data were recorded at a base samping rate of %i Hz (a detail not recorded in the file header). Please change params.native_sampling_rate to the correct value if this is wrong.',params.native_sampling_rate)
                if ~shift_data
                    warning('Note that the timing delay correction is only applied to the recording segment time stamps, but the offset in data samples is not adjusted. Channels subsampled at different rates from each other are still misaligned with respect to sample index. The correcion only means that any delay is now reflected in the respecive time stamps.')
                end
            end
            high_cut_enabled = strcmpi(data(k).header.DSPHighCutFilterEnabled,'True') && strcmpi(data(k).header.DspHighCutFilterType,'FIR');
            low_cut_enabled = strcmpi(data(k).header.DSPLowCutFilterEnabled,'True')&& strcmpi(data(k).header.DspLowCutFilterType,'FIR');
            low_cut_freq = str2double(data(k).header.DspLowCutFrequency);
            if low_cut_enabled || high_cut_enabled
                ntaps = high_cut_enabled*str2double(data(k).header.DspHighCutNumTaps) + low_cut_enabled*str2double(data(k).header.DspLowCutNumTaps)-1;
                high_cut_freq = str2double(data(k).header.DspHighCutFrequency);
                err_factor = params.native_sampling_rate/data(k).fs;
    %             if high_cut_enabled || low_cut_enabled
    %                 data(k).header.DspHighCutFrequency = 
                assumed_delay = str2double(data(k).header.DspFilterDelay_us);
                correct_delay = ntaps./params.native_sampling_rate/2*1e6;

                delay_correction = assumed_delay-correct_delay;

                data(k).header.ApplicationName = sprintf('%s subsampling bug fix applied by extraction script.',deblank(data(k).header.ApplicationName));
                data(k).header.SubsamplingBugFix = 'True';
                ccl = {'True','False'};
                data(k).header.SubsamplingBugFixDataResampled = ccl{shift_data+1};
                data(k).header.BugFixDelayCorrection = sprintf('%f',delay_correction);
                data(k).header.DspFilterDelay_us = sprintf('%i',round(correct_delay));
                if high_cut_enabled
                    data(k).header.DspHighCutFrequency = sprintf('%f',high_cut_freq*err_factor);
                end
                if low_cut_enabled
                     data(k).header.DspLowCutFrequency = sprintf('%f',low_cut_freq*err_factor);
                end
            end
        end
        
    else
        warned = []; %#ok<*NASGU>
    end
    
    
    params.ndatabytes = round(log2(str2num(data(k).header.ADMaxValue))+1)/8;
    
    params.nsamp  = (str2num(data(k).header.RecordSize)-params.samphead_bytes)./params.ndatabytes;
    
    params.scale = str2num(data(k).header.ADBitVolts)*params.unitVscale;
    
    if params.enforce_polarity && strcmpi(data(k).header.InputInverted,'true')
        warning(sprintf('The "InputInverted" flag is "True." Data sign will be flipped to compensate for this.\nSet params.enforce_polarity = false if this is not what you want'))
        params.scale = -params.scale;
        data(k).header.InputInverted = 'False';
    elseif strcmpi(data(k).header.InputInverted,'true')
        warning(sprintf('The "InputInverted" flag is "True." \nSet params.enforce_polarity = true to automatically compensate for this by flipping the sign.')) %#ok<*SPWRN>
       
    end
        
    
    % get the sampleheader_values
     skip = 0;
    databytes = params.ndatabytes*params.nsamp;
    for kk = 1:length(sampheadfn)
        fseek(fid,params.header_bytes+skip,-1);
        data(k).(sampheadfn{kk}) = fread(fid,[params.samphead.(sampheadfn{kk}),'=>',params.samphead.(sampheadfn{kk})],databytes+params.samphead_bytes-sampheadbyteN(kk));
        skip = skip+sampheadbyteN(kk);
    end
    if ~params.headers_only
       % Get the data
        nrec = length(data(k).TimeStamp);

        dat = zeros(params.nsamp,nrec);
        fseek(fid,params.header_bytes+skip,-1);          
        dat(:)  = fread(fid,sprintf('%i*%s=>single',params.nsamp,params.data_precision),params.samphead_bytes)*params.scale;

        %%% Retain only valid samples within each block
        incomplete_chunks = find(data(k).NumValidSamples < params.nsamp);
        invalid = false(params.nsamp,nrec);
        invalid((incomplete_chunks-1)*params.nsamp + double(data(k).NumValidSamples(incomplete_chunks) + 1)) = true;     
        invalid = cumsum(invalid)>0;
        
       dt = round(double(diff(data(k).TimeStamp)).*double(data(k).SampFreq(1:end-1))/1e6);
       %Missing samples based on the difference between dt and recorded
        %number of samples
        if any(dt~=params.nsamp)
            samplestep = double(~invalid);
            samplestep(1,2:end) =  samplestep(1,2:end)' + dt-double(data(k).NumValidSamples(1:end-1));
            sampleindex = cumsum(samplestep(:));
            sampleindex = sampleindex(~invalid);
            numMissing = sum(samplestep(~invalid)-1);
            ntot = numel(dat)-sum(invalid(:));
            data(k).dat = zeros(ntot-numMissing,1);
            data(k).dat(sampleindex) = dat(~invalid);
            missingSamples = true(length(data(k).dat)+1,1);
            missingSamples([0;sampleindex]+1) = false;
            missingSamples = sparse(diff(missingSamples));
            warning('%i samples are missing (%f%%).',numMissing,numMissing/ntot*100)
        else
            data(k).dat = dat(:);
            missingSamples = spalloc(length(dat(:)),1,0);
            numMissing = 0;
        end
        data(k).missingSamples = missingSamples;
        data(k).numberofSamplesMissing = numMissing;
       
     else
        data(k).dat=[];
        data(k).missingSamples = sparse([]);
        data(k).numberofSamplesMissing = [];
    end
    [~,data(k).name] = fileparts(fn);
    switch params.unitVscale
        case 1e6
            data(k).units='uV';
        case 1e3
            data(k).units='mV';
        case 1
            data(k).units='V';
        otherwise
             data(k).units=sprintf('%fxV',params.unitVscale);
    end
    data(k).time_fmt = 'unix_usec';   
    data(k).file = fnames{k};
    data(k).path= path;
    
    if delay_correction~=0 
        if ~shift_data
            data(k).TimeStamp = data(k).TimeStamp+uint64(round(delay_correction));
        elseif ~params.headers_only
            ndelay = round(delay_correction/1e6*data(k).fs);
            data(k).dat = circshift(data(k).dat,[ndelay 0]);
            if k==1
                warning(sprintf('Data have been shifted by %i samples to compensate for the timing bug.\nThis may have unintended consquences; for example, changes during data acquisition will not align with the start of a frame. \nThe recommended way to handle this is to apply the correction to time stamps. Your scripts should be reconciling event times based on the time stamps, anyway, not on the assumption that recordings are synchronous in all channels.\nOK, you''ve been warned.',ndelay) ) 
            end

        end     
    end
    warned = true;
end
fclose(fid);
