# 6 Efficient Programming for EEG Data Analysis in MATLAB

## Table of Contents

1. [Advanced Preprocessing and Data Organization](#61-advanced-preprocessing-and-data-organization)
   - [Utilize efficient data structures](#611-utilize-efficient-data-structures)
   - [Vectorization](#612-vectorization)
   - [Memory management](#613-memory-management)
2. [Parallel Computing](#62-parallel-computing)
   - [Parallelize computations](#621-parallelize-computations)
   - [GPU computing](#622-gpu-computing)
3. [Algorithm Optimization](#63-algorithm-optimization)
   - [Algorithmic efficiency](#631-algorithmic-efficiency)
   - [Profiling and optimization](#632-profiling-and-optimization)
4. [Memory and I/O Optimization](#64-memory-and-io-optimization)
   - [Minimize disk I/O operations](#641-minimize-disk-io-operations)
   - [Memory-efficient operations](#642-memory-efficient-operations)
5. [Modularity and Reusability](#65-modularity-and-reusability)
   - [Function and script design](#651-function-and-script-design)
   - [Libraries and toolboxes](#652-libraries-and-toolboxes)
6. [Testing and Debugging](#66-testing-and-debugging)
   - [Unit testing](#661-unit-testing)
   - [Debugging techniques](#662-debugging-techniques)


**Our BioHPC usage is constanly monitored, exssive use of BioHPC CPU and GUP will result in an unwanted surchage bill. Also Do NOT save time-frequency representation (TFR) of your result on BioHPC. 3 dimentional TFRs takes a lot of storage and will also result in a big bill**

Efficient programming plays a crucial role in the analysis of EEG (electroencephalogram) data. MATLAB provides a powerful environment for EEG analysis, but optimizing code execution time and memory usage can significantly enhance productivity and data processing capabilities. This chapter focuses on techniques and best practices for efficient programming in MATLAB specifically tailored for EEG data analysis in our lab.

It is recommended to debug and test your code **on your local machine** before scaling it up to process larger datasets. To facilitate this process, we suggest using a smaller subset of **EEG data drawn from a single subject and a single electrode**. By focusing on a specific subject and electrode, you can isolate and examine the behavior of your code more effectively, allowing for faster iterations and efficient debugging.

**BioHPC Resource Usage and Cost Considerations:**
To ensure smooth operations and avoid unexpected surcharge bills, it is important to be mindful of our BioHPC resource usage, particularly CPU and GPU resources. The BioHPC infrastructure continuously monitors resource consumption, and excessive usage can result in additional charges. Therefore, it is essential to optimize our code to minimize resource utilization while still achieving accurate and reliable results.

Additionally, it is strongly advised not to save time-frequency representations (TFRs) of your results directly on BioHPC. Storing three-dimensional TFRs requires a significant amount of storage space, leading to increased storage costs and potential surcharges. Instead, we recommend employing efficient data processing strategies that extract relevant information from the TFRs during runtime and store only the necessary processed data or summary statistics. By doing so, you can effectively manage storage requirements and avoid incurring additional expenses.

**Debugging and Testing on Local Machines:**
For efficient code development and effective troubleshooting, it is highly recommended to debug and test your code on a local machine using a smaller subset of EEG data. By working with data drawn from a single subject and one electrode, you can isolate and examine code behavior more effectively, leading to quicker iterations and efficient debugging.

Debugging on a smaller dataset offers several advantages. It reduces computational requirements, enabling faster code execution and rapid turnaround times during the debugging phase. Moreover, the reduced complexity of the data simplifies error identification, facilitating faster troubleshooting. Lastly, working with a limited dataset allows for code optimization, enabling you to address any performance bottlenecks early on in the development process.

## 6.1 Advanced Preprocessing and Data Organization:
Preprocessing and Data Organization:

- **a. Utilize efficient data structures:**
   Suppose you have EEG data consisting of raw signals, event markers, and behavioral data. You can organize and store this data using MATLAB data structures such as cell arrays and structures.

   ```matlab
   % Sample EEG data
   rawSignals = [1 2 3; 4 5 6; 7 8 9]; % Example raw EEG signals
   eventMarkers = {'Marker A', 'Marker B', 'Marker C'}; % Example event markers
   behavioralData = struct('SubjectID', 'S001', 'Age', 25, 'Gender', 'Male'); % Example behavioral data
   % Store data in a structure
   eegData = struct('RawSignals', rawSignals, 'EventMarkers', eventMarkers, 'BehavioralData', behavioralData);
   ```
   In this example, `rawSignals` represents the raw EEG signals, `eventMarkers` contains the corresponding event markers, and `behavioralData` is a structure containing behavioral information. All these data are stored within a larger structure called `eegData`, allowing for convenient organization and access.

- **b. Vectorization:**
   Vectorization is particularly useful when performing operations on EEG data to minimize execution time. Here's an example of applying a common preprocessing step, normalization, using vectorized operations:

   ```matlab
   % Normalizing EEG signals
   normalizedSignals = (rawSignals - mean(rawSignals, 2)) ./ std(rawSignals, 0, 2);
   ```
   In this example, `mean(rawSignals, 2)` calculates the mean along each row (channel) of the `rawSignals` matrix, and `std(rawSignals, 0, 2)` computes the standard deviation. The subtraction and division operations are then applied element-wise using vectorized operations to normalize the signals.

- **c. Memory management:**
   When dealing with large EEG datasets, it's essential to manage memory efficiently to avoid unnecessary data duplication and clear variables when they are no longer needed. Here's an example illustrating memory management techniques:

   ```matlab
   % Load large EEG dataset
   load('large_dataset.mat', 'eegData');

   % 
   % Perform preprocessing on eegData
   % ...

   % Clear variables to free up memory and use processed data
   clear eegData;
   ```
   In this example, the `load` function is used to load a large EEG dataset stored in a MAT file. Once the analysis on `eegData` is complete, the `clear` command is used to remove the `eegData` variable from the MATLAB workspace, freeing up memory resources.
   By efficiently using MATLAB data structures, leveraging vectorized operations, and managing memory effectively, you can optimize your preprocessing and data organization workflow for EEG data in MATLAB.

In practical scenarios, it is often beneficial to reorganize raw EEG data obtained from a lab database, especially when the raw data is stored in binary format and requires access through a specialized system like biohpc or a VPN connection when off campus. By reorganizing the EEG data of multiple subjects, you can transfer the data to your local machine and store it conveniently. Additionally, you can preprocess the data once and save the preprocessed results locally. This approach eliminates the need for repetitive data retrieval and preprocessing, saving time and effort in future analyses. Having the data readily available on your local machine facilitates efficient access and reduces dependence on remote access or complex connectivity requirements.

**Here's an example script in MATLAB**

```matlab 
% EEG Data Conversion and Preprocessing Script
% This MATLAB script converts raw EEG data to preprocessed MATLAB .mat
% files using gete_ms funciton in the EEG_toolbox.
% It retrieves raw EEG data from the lab database and reorganizes the data.
% The preprocessed data is then saved as separate .mat files for each subject.
% David Wang 
% 05/19/2023

clear
close all
clc

% Define the list of subjects
subjList = {'UT004';'UT025';'UT035';'UT037'};

% Define the channels of interest
channels = 1:128;

% Loop through each subject
for subjInd = 1:length(subjList)
    % Check if the events file exists for the current subject
    if exist(sprintf('/Volumes/project/TIBIR/Lega_lab/shared/lega_ansir/subjFiles/%s/behavioral/FR1/events.mat', subjList{subjInd}), 'file')
        % Load talStruct data for electrode locations
        load(sprintf('/Volumes/project/TIBIR/Lega_lab/shared/lega_ansir/subjFiles/%s/tal/%s_talLocs_database_monopol.mat', subjList{subjInd}, subjList{subjInd}));
        
        % Filter talStruct based on the selected channels
        talStruct = talStruct(ismember([talStruct.channel]', channels));
        
        % Filter events data for non-empty eegfile field
        events = events(cellfun(@(x) ~isempty(x), {events.eegfile}'));
        
        % Update the eegfile paths to the full file paths
        for idx = 1:length(events)
            events(idx).eegfile = fullfile('/Volumes', events(idx).eegfile);
        end
        
        % Extract retrieval events and baseline events
        events_retrieval = getRetrievalEvents_NEW(events, [1000, 500]);
        events_retrieval_baseline = events_retrieval.recCntl;
        events_retrieval = events_retrieval.rec;
        
        % Filter events for the 'WORD' type
        events = events(cellfun(@(x) strcmp(x, 'WORD'), {events.type}'));
        
        % Initialize EEG matrix for the main events
        eeg = nan(length(channels), length(events), 1800);
        
        % Loop through each channel and extract EEG data for the main events
        for idx = 1:length(channels)
            [eeg(idx, :, :)] = gete_ms(channels(idx, 1), events, 1800, 0, 0, [58 62], 'stop', 1);
        end
        
        % Initialize EEG matrix for the retrieval events
        eeg_retrieval = nan(length(channels), length(events_retrieval), 1000);
        
        % Loop through each channel and extract EEG data for the retrieval events
        for idx = 1:length(channels)
            [eeg_retrieval(idx, :, :)] = gete_ms(channels(idx, 1), events_retrieval, 1000, -1000, 0, [58 62], 'stop', 1);
        end
        
        % Save the preprocessed data as a MATLAB .mat file
        save(sprintf('/yourfolder/example_data/%s.mat', subjList{subjInd}), 'events', 'eeg', 'eeg_retrieval', 'talStruct', 'channels')
    end
end
```


## 6.2 Parallel Computing:
- **a. Parallelize computations:** 
   Take advantage of MATLAB's parallel computing capabilities (e.g., parallel for-loops, parfor) to distribute computationally intensive tasks across multiple cores or processors.

   **Example: Computing average EEG power across trials using parallel for-loops:**
   ```matlab
   % Load the EEG data (Assuming the data is stored in a 3D matrix called 'eegData')
   load('eegData.mat');

   % Initialize variables
   [numChannels, numTrials, numTimePoints] = size(eegData);
   averagePower = zeros(numChannels, numTimePoints);

   % Perform computation in parallel using parfor
   parfor c = 1:numChannels
      for t = 1:numTimePoints
         averagePower(c, t) = mean(abs(hilbert(eegData(c, :, t))).^2);
      end
   end
   ```

-**b. GPU computing:** 
   Explore GPU acceleration for specific EEG data analysis tasks, such as time-frequency analysis or machine learning algorithms, to leverage the parallel processing power of graphics cards.

   **Example: Time-frequency analysis using GPU acceleration:**
   ```matlab
   % Load the EEG data (Assuming the data is stored in a 3D matrix called 'eegData')
   load('eegData.mat');

   % Transfer the EEG data to the GPU
   eegDataGPU = gpuArray(eegData);

   % Define frequency range
   frequencies = 1:100; % Example frequency range

   % Initialize power spectrogram on the GPU
   powerSpectrogram = zeros(numChannels, numTrials, length(frequencies), 'gpuArray');

   % Perform time-frequency analysis using GPU acceleration
   for c = 1:numChannels
      for t = 1:numTrials
         powerSpectrogram(c, t, :) = computePowerSpectrogram(eegDataGPU(c, t, :), frequencies);
      end
   end

   % Function to compute the power spectrogram for a single channel and trial
   function psd = computePowerSpectrogram(eegSignal, frequencies)
      fs = 1000; % Example sampling rate (in Hz)
      eegSignal = reshape(eegSignal, 1, []); % Reshape to a 1D signal
      [psd, ~] = pwelch(gather(eegSignal), [], [], frequencies, fs);
   end
   ```
In these examples, the computations are performed considering the structure of the EEG data as channel by trial by time. The parallel for-loops or GPU acceleration is applied accordingly to distribute the computations across multiple cores/processors or leverage the parallel processing power of the GPU for improved efficiency and speed. Adjust the computations based on your specific analysis requirements and EEG data structure.

## 6.3 Algorithm Optimization:
**a. Algorithmic efficiency:** Implement efficient algorithms tailored to specific EEG data analysis tasks, such as filtering, artifact removal, spectral analysis, or feature extraction. Consider existing MATLAB functions and toolboxes optimized for EEG analysis.
**b. Profiling and optimization:** Use MATLAB's profiling tools (e.g., the Profiler) to identify and optimize the most time-consuming parts of the code. Optimize critical sections using techniques like algorithmic improvements, code vectorization, and preallocation.

Here's an example of algorithmic efficiency improvement in MATLAB for EEG data analysis. We'll focus on filtering the EEG data before and after optimization:
Before Optimization:
```matlab
% Load the EEG data (Assuming the data is stored in a 3D matrix called 'eegData')
load('eegData.mat');

% Apply a bandpass filter to the EEG data using MATLAB's built-in filter function
fs = 1000; % Example sampling rate (in Hz)
filterOrder = 4; % Example filter order
cutoffFreqs = [1 50]; % Example cutoff frequencies (in Hz)

filteredData = zeros(size(eegData)); % Initialize filtered data matrix

for c = 1:size(eegData, 1)
    for t = 1:size(eegData, 2)
        for p = 1:size(eegData, 3)
            % Compute filter coefficients for each channel, trial, and time point
            [b, a] = butter(filterOrder, cutoffFreqs/(fs/2), 'bandpass');
            
            % Apply zero-phase filtering to each time point of each trial of each channel
            filteredData(c, t, p) = filtfilt(b, a, eegData(c, t, p));
        end
    end
end
```

After Optimization:
```matlab
% Load the EEG data (Assuming the data is stored in a 3D matrix called 'eegData')
load('eegData.mat');

% Apply a bandpass filter to the EEG data using MATLAB's built-in filter function
fs = 1000; % Example sampling rate (in Hz)
filterOrder = 4; % Example filter order
cutoffFreqs = [1 50]; % Example cutoff frequencies (in Hz)

% Compute filter coefficients
[b, a] = butter(filterOrder, cutoffFreqs/(fs/2), 'bandpass');

% Reshape the EEG data to a 2D matrix for efficient filtering
reshapedData = reshape(eegData, [], size(eegData, 3));

% Apply zero-phase filtering to the reshaped data
filteredData = filtfilt(b, a, reshapedData);

% Reshape the filtered data back to the original shape
filteredData = reshape(filteredData, size(eegData));
```

In the optimized version, the filtering process is improved by reshaping the 3D EEG data to a 2D matrix before applying the filter. This allows us to perform the filtering operation on the entire matrix in one step, which is more efficient than nested loops. After filtering, the filtered data is reshaped back to the original 3D shape.


## 6.4 Memory and I/O Optimization:
**a. Minimize disk I/O operations:** Reduce unnecessary read/write operations from disk by optimizing file access strategies, using memory-mapped files, or preloading data into memory.
**b. Memory-efficient operations:** Use memory-efficient techniques like streaming and block processing to avoid loading the entire dataset into memory simultaneously, particularly for long EEG recordings.

## 6.5 Modularity and Reusability:
**a. Function and script design:** Organize EEG data analysis code into modular functions or scripts, promoting code reusability, maintainability, and readability.

**b. Libraries and toolboxes:** Take advantage of existing MATLAB libraries and toolboxes specifically designed for EEG analysis to leverage optimized functions and workflows.

**Here's an example of function and script design in MATLAB for EEG data analysis:**

Function Design:
```matlab
% Function: computeAveragePower
% Computes the average power across trials for each channel in EEG data
% Inputs:
%   - eegData: 3D matrix representing the EEG data (channel by trial by time)
% Outputs:
%   - averagePower: Column vector containing the average power for each channel

function averagePower = computeAveragePower(eegData)
    numChannels = size(eegData, 1);
    numTrials = size(eegData, 2);
    numTimePoints = size(eegData, 3);

    reshapedData = reshape(eegData, [], numTimePoints);
    sumPower = sum(abs(reshapedData).^2, 2);
    averagePower = sumPower / (numTrials * numTimePoints);
    averagePower = reshape(averagePower, numChannels, []);
end
```

Script Design:
```matlab
% Script: eegAnalysisScript
% An example script to demonstrate EEG data analysis using the computeAveragePower function

% Load the EEG data (Assuming the data is stored in a matrix called 'eegData')
load('eegData.mat');

% Call the computeAveragePower function to compute the average power
averagePower = computeAveragePower(eegData);

% Display the results
disp('Average Power for Each Channel:');
disp(averagePower);
```

In this example, a function called `computeAveragePower` is designed to compute the average power across trials for each channel in the EEG data. The function takes the EEG data matrix as input and returns a column vector containing the average power for each channel.

The script `eegAnalysisScript` demonstrates the usage of the `computeAveragePower` function. It loads the EEG data, calls the function to compute the average power, and displays the results.

By designing modular functions and separating the analysis logic into functions and scripts, you can enhance code organization, reusability, and maintainability for EEG data analysis tasks.


## 6.6 Testing and Debugging:
**a. Unit testing:** Implement unit tests to ensure the correctness and stability of individual functions or modules.

**b. Debugging techniques:** Familiarize yourself with MATLAB's debugging tools (e.g., breakpoints, the MATLAB Debugger) to identify and fix code errors efficiently.

```matlab
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
```
