%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% House-keeping
clearvars; close all; clc;

if ismac
   rootDir = '/Volumes'; 
else
    rootDir = '';
end

% Add path to toolbox
% addpath(genpath(fullfile(rootDir, '/project/TIBIR/Lega_lab/shared/lega_ansir/shared_code/eeg_toolbox')))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initiate variables
params.subjDir = fullfile(rootDir, '/project/TIBIR/Lega_lab/shared/lega_ansir/subjFiles');
params.subjs = dir(params.subjDir);
params.subjs = {params.subjs(cellfun(@(x) any(regexp(x,'UT[0-9][0-9][0-9]'))|any(regexp(x,'CC[0-9][0-9][0-9]')),{params.subjs.name}') & ...
               cellfun(@(x) ~any(strfind(x, '._')),{params.subjs.name}')).name}'; % only keep files with format 'UT###' or 'CC###' that do not contain characters '._' 

params.paradigms = {'FR1', 'pyFR'};
params.freqs = eeganalparams('freqs'); % 53 log spaced frequencies (2-181 Hz) saved in text file in the iEEGDatabase on BioHPC
params.regions = {'Posterior_cingulate'};
params.saveDir = '/endosome/work/TIBIR/s436872/scripts';
if ~exist(params.saveDir,'dir')
    mkdir(params.saveDir)
end
channel = 1;
DurationMS = 1800;
OffsetMS = -200;
BufferMS = 500;
filtfreq = [58, 62];
filttype = 'stop';
filtorder = 1;
resampleFreq = 1000;
kThresh = 4;

for subjInd = 1:length(params.subjs) % loop through subjects
    
    thisSubject = params.subjs{subjInd,1}; % save subject name
    thisSubject_behDir = fullfile(params.subjDir, thisSubject, 'behavioral');
    
    % load subject tal struct
    load(fullfile(params.subjDir, thisSubject,'tal', [thisSubject, '_talLocs_database_monopol.mat']))
    
   for paraInd = 1:length(params.paradigms) % loop through paradigms
       
       thisParadigm = params.paradigms{1,paraInd}; % save paradigm name
       thisParadigm_dir = fullfile(thisSubject_behDir, thisParadigm);
       
       if exist(thisParadigm_dir,'dir') % only continue if subject has this paradigm
           load(fullfile(thisParadigm_dir,'events.mat'))
           
           if ismac % fix eegfile path for mac 
              for idx = 1:length(events)
                 events(idx).eegfile = fullfile(rootDir, events(idx).eegfile);
              end
           end
           
          % Filter for trials of interest -- type 'WORD'
          events = events(cellfun(@(x) strcmp(x,'WORD'), {events.type}'));
          recEvents = events([events.recalled]'==1);
          nonEvents = events([events.recalled]'==0);
        
          talStruct_temp = talStruct;
          
            for regInd = 1:length(params.regions)
               thisRegion = params.regions{regInd};
               
               if ~exist(fullfile(params.saveDir, thisRegion), 'dir')
                   mkdir(fullfile(params.saveDir, thisRegion))
               end
               % Filter talStruct for channels in this region
               talStruct = talStruct_temp;
               talStruct = talStruct(cellfun(@(x) any(strfind(x, thisRegion)), {talStruct.IP_loc}'));
               
               % Loop through channels in this region and get power
               %recPow =  getphasepow(talStruct(chanInd).channel,events,DurationMS,OffsetMS,BufferMS,'filtfreq', filtfreq, 'filttype', filttype, 'filtorder', filtorder,'kThresh', kThresh);  
               for chanInd = 1:length(talStruct)
                  [~, recPow(:,:,:), ~] = getphasepow(talStruct(chanInd).channel,recEvents,DurationMS,OffsetMS,BufferMS,'filtfreq', filtfreq, 'filttype', filttype, 'filtorder', filtorder,'kThresh', kThresh);  
                  [~, nonPow(:,:,:), ~] = getphasepow(talStruct(chanInd).channel,nonEvents,DurationMS,OffsetMS,BufferMS,'filtfreq', filtfreq, 'filttype', filttype, 'filtorder', filtorder,'kThresh', kThresh);  
                   
                  save(fullfile(params.saveDir, thisRegion, sprintf('%s_ch_%d.mat', thisSubject,talStruct(chanInd).channel)), 'recPow', 'nonPow')
               end
            end
       else
           continue
       end
       
   end % end loop through paradigms
   
end % end loop through subjects
