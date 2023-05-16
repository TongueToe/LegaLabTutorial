
% PURPOSE:
%
% INPUT(S):
% 
% OUTPUT(S): 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Housekeeping
clearvars; close all; clc;
if ismac
    rootDir = '/Volumes';
else
    rootDir = '';
    addpath(genpath(fullfile(rootDir, '/project/TIBIR/Lega_lab/shared/lega_ansir/shared_code/data_preprocessing')))
    addpath(genpath(fullfile(rootDir, '/project/TIBIR/Lega_lab/shared/lega_ansir/shared_code/eeg_toolbox')))
end

day = '5_20_2021';
version = '.settings_you_want_to_define'; 
runName = strcat(day,version);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

makeLockFiles = 1;


% Run and save data paths
saveDir = fullfile(rootDir, '/work/TIBIR/s193084/where/to/save/data', runName);
if ~exist(saveDir, 'dir')
    mkdir(saveDir)
end

% define subjects
allsubjs = {'UT098' 'UT108' 'UT111' 'UT114'  'UT121' 'UT122' 'UT130' ...
    'UT151' 'UT152' 'UT162' 'UT097' 'UT101' 'UT104' 'UT113' 'UT123' 'UT132' 'UT186'};

% define regions of interest
ROIs = {'AH_Left','AH_Right','PH_Left','PH_Right'};

%% Define parameters:
% gete_ms parameters
params.freqs = (2^(1/8)).^(8:53); % use 8:49 for max 70 Hz, use 8:53 for max 100 Hz, use 8:56 for max 128 Hz
params.sampFreq = 1000; % sampling frequency
params.downsampleRate = 500; % can downsample to 500 to save computational efficiency
params.encodeDur = 1600; 
params.encodeOff = 0;
params.bufferMS = 500;
params.lineNoise = [58 62]; % regular line noise is 60 Hz
params.lineNoise4harm = [58 62; 118 122; 178 182; 238 242]; % can also filter at harmonics of 60 Hz
params.lowpass = 250; % filter that only allows signal below 250 Hz to get through
params.highpass = 1;
params.kThresh = 4; % for using kurtosis
params.encodeDur_norm = 800; % settings for power used for normalization
params.encodeOff_norm = -1500; % in this case we are using the the period 
% from -1500 ms to -700 ms before each encoding event

% Save params file 
if ~exist(fullfile(saveDir, 'params.mat'), 'file')
    save(fullfile(saveDir, 'params.mat'), 'params')
end

% Make folder for lock files
lockDir = fullfile(saveDir, 'lock_files');
if ~exist(lockDir, 'dir') && makeLockFiles == 1
    mkdir(lockDir)
end

% Make folder for lock and save files
genericSubjsaveDir = fullfile(saveDir, '%s');
genericSubjStartDir = fullfile(saveDir,'lock_files', '%s_START');
genericSubjLockDir = fullfile(saveDir, 'lock_files', '%s_X_LOCK');


%% Get subject/electrode information from AAL_table file

% Loads AAL_table matfile which contains the variable, AAL_table, a cell
% array that looks and works just like the BA sheet
load('/project/TIBIR/Lega_lab/shared/lega_ansir/subjFiles/AAL_table.mat');
AALdata = AAL_table;

% Now get rid of columns that do not correspond to region(s) of interest.
% ROIs is a cell array using the AAL short names 
% (e.g. ROIs = {'AH_L','AH_R','PH_L','PH_R'} for anterior/posterior
% hippocampus)
colsUse = cellfun(@(x) isempty(x)|any(contains(x,ROIs)), AALdata(1,:));
AALdata = AALdata(:,colsUse);

% Now get rid of all subjects who are not stim subjects listed above
% ROIs is a cell array of subject codes 
% (e.g. allsubjs = {'UT050','UT101','UT160'} if you're only interested in
% certain subjects)
subjsUse = cellfun(@(x) isempty(x)|any(contains(x,allsubjs)), AALdata(:,1));
AALdata = AALdata(subjsUse,:);

% full AALdata is stored in params.electrodes.info
info = AALdata;

% extract list of subjects and regions from AAL data
subjects = info(2:end,1);
regions = AALdata(1,2:end);

%% loop through subjects
for subjInd = 1:length(subjects)
    
    thisSubj = subjects{subjInd};
    thisSubj_saveDir = sprintf(genericSubjsaveDir, subjects{subjInd});
    thisSubj_startDir = sprintf(genericSubjStartDir, subjects{subjInd});
    thisSubj_lockDir = strrep(sprintf(genericSubjLockDir, subjects{subjInd}), 'X', '%s');
    
    % get the list of regions for which this subject has electrodes 
    subj_regions = info(1,logical([0,cellfun(@(x) ~isempty(x), info(subjInd+1,2:end))]));
    if isempty(subj_regions)
        continue
    end
    
    subject_regions = cell(length(subj_regions), 2);
    subject_regions(:,1) = subj_regions;
    
    clearvars ev
    % Define which events to load
    % you can load events from subjFiles or save events locally and change
    % this path accordingly
    thisSubj_eventsDir = fullfile('/project/TIBIR/Lega_lab/shared/lega_ansir/subjFiles/path/to/events.mat',subjects{subjInd});
    ev = load(thisSubj_eventsDir);
    
    
    %% Loop through regions
    for regInd = 1:length(subj_regions)
        regName_forSaving = subj_regions{regInd};
         
        % make lock files
        if  ~exist(sprintf(thisSubj_lockDir, regName_forSaving), 'file')
            if makeLockFiles==1
                fid = fopen(sprintf(thisSubj_lockDir, regName_forSaving),'w'); fclose('all');
            end
            
            try
                % Determine which electrodes this subject has in this region
                region_column = find(cellfun(@(x) strcmp(x, subj_regions{regInd}), info(1,:)));
                subj_elecs = info{cellfun(@(x) strcmp(x, subjects{subjInd,1}), info(:,1)), region_column}; 
                % load subject electrodes
                
                if isempty(subj_elecs)
                    continue
                end
                   
                count = 0;
                % If the subject has electrodes, now make folder to
                % save data
                thisReg_saveDir = fullfile(thisSubj_saveDir, regName_forSaving);
                if ~exist(thisReg_saveDir , 'dir')
                    mkdir(thisReg_saveDir)
                end
                
                % initialize variables that will be used to concat later
                normPower =[];              
                
                %% Loop through each electrode for this subject within this region
                for elecInd = 1:length(subj_elecs)
                    
                    subject = subjects{subjInd};
                    thisElec = subj_elecs(elecInd);
                    
                    
                    % this is where you would do some events filtering
                    % kurtosis, median-based artifact rejection, etc
                    
                    % define the events that you want to extract power for
                    WordEvents = filterStruct(events, 'strcmp(type,''WORD'')');

                    
                    %% get phase pow
                    
                    % power for encoding events
                    [~,power] = getphasepow(thisElec,WordEvents,params.encodeDur,params.encodeOff,params.bufferMS,...
                        'freqs',params.freqs,'filtfreq',params.lineNoise4harm,'filttype','stop','filtorder',1);
                       
                    % power for baseline prior to each encoding event
                    % do this by changing the encodeOff and encodeDur
                    [~,power_baseline] = getphasepow(thisElec,WordEvents,params.encodeDur_norm,params.encodeOff_norm,params.bufferMS,...
                        'freqs',params.freqs,'filtfreq',params.lineNoise4harm,'filttype','stop','filtorder',1);

                    
                    %% baseline normalizing power (Z-transform)
                    
                    % baseline normalization for encoding events
                    encode_mean_3 = mean(power_baseline,3);
                    encode_std = nanstd(encode_mean_3);
                    encode_mean = nanmean(encode_mean_3);
                    
                    % normalize power using baseline 
                    power_norm = (power-repmat(encode_mean,[size(power,1) 1 size(power,3)]))./ repmat(encode_std,[size(power,1) 1 size(power,3)]);
                
                    
                    %% average and concat normalized power values for each electrode
                    
                    % average across events to get an 
                    % elec x freq x time matrix of normpow values
                    normPower = [normPower; nanmean(power_norm)];
                   
                    
                end % end loop through electrodes
                
                %% saving data
                
                % Save the norm pow values for each subj/region --> rows=electrode,column=freq, page=time
                save(fullfile(thisReg_saveDir,sprintf('%s_%s_normpow.mat',subject,regName_forSaving)),'normPower');
                
                
            catch e
                if makeLockFiles == 1
                    thisSubjError = fullfile([strrep(sprintf(thisSubj_lockDir, regName_forSaving), 'LOCK', 'ERROR_ERROR_ERROR'), '.mat']);
                    fid = fopen(thisSubjError,'w');fclose('all');
                    save(thisSubjError,'e')
                    clear vars thisSubjError
                end
                continue
                
            end % end try statement
            
            subject_regions{regInd,2} = 1;
            
            if makeLockFiles==1
                fid = fopen(strrep(sprintf(thisSubj_lockDir, regName_forSaving), 'LOCK', 'DONE'), 'w'); fclose('all');
            end
            
        end % end conditional statement checking for lock file
        
    end % end loop through regions
       
end % end loop through subjects

save(fullfile(saveDir, 'params.mat'), 'params')

