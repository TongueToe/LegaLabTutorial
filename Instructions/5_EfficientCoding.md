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
   % Perform preprocessing eegData
   % ...

   % Clear variables to free up memory and use processed data
   clear eegData;
   ```
   In this example, the `load` function is used to load a large EEG dataset stored in a MAT file. Once the analysis on `eegData` is complete, the `clear` command is used to remove the `eegData` variable from the MATLAB workspace, freeing up memory resources.
   By efficiently using MATLAB data structures, leveraging vectorized operations, and managing memory effectively, you can optimize your preprocessing and data organization workflow for EEG data in MATLAB.





## 6.2 Parallel Computing:
a. Parallelize computations: Take advantage of MATLAB's parallel computing capabilities (e.g., parallel for-loops, parfor) to distribute computationally intensive tasks across multiple cores or processors.
b. GPU computing: Explore GPU acceleration for specific EEG data analysis tasks, such as time-frequency analysis or machine learning algorithms, to leverage the parallel processing power of graphics cards.

## 6.3 Algorithm Optimization:
a. Algorithmic efficiency: Implement efficient algorithms tailored to specific EEG data analysis tasks, such as filtering, artifact removal, spectral analysis, or feature extraction. Consider existing MATLAB functions and toolboxes optimized for EEG analysis.
b. Profiling and optimization: Use MATLAB's profiling tools (e.g., the Profiler) to identify and optimize the most time-consuming parts of the code. Optimize critical sections using techniques like algorithmic improvements, code vectorization, and preallocation.

## 6.4 Memory and I/O Optimization:
a. Minimize disk I/O operations: Reduce unnecessary read/write operations from disk by optimizing file access strategies, using memory-mapped files, or preloading data into memory.
b. Memory-efficient operations: Use memory-efficient techniques like streaming and block processing to avoid loading the entire dataset into memory simultaneously, particularly for long EEG recordings.

## 6.5 Modularity and Reusability:
a. Function and script design: Organize EEG data analysis code into modular functions or scripts, promoting code reusability, maintainability, and readability.
b. Libraries and toolboxes: Take advantage of existing MATLAB libraries and toolboxes specifically designed for EEG analysis to leverage optimized functions and workflows.

## 6.6 Testing and Debugging:
a. Unit testing: Implement unit tests to ensure the correctness and stability of individual functions or modules.
b. Debugging techniques: Familiarize yourself with MATLAB's debugging tools (e.g., breakpoints, the MATLAB Debugger) to identify and fix code errors efficiently.

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