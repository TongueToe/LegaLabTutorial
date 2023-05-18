# 3-EEG_database


## 3.1 Behavioral-Tasks

### 3.1.1 Free Recall (FR) Task

### 3.1.2 Assciocative Recognition (AR) Task 
you can find detailed explanation of AR task here: [AR Task](../src/ar_task_explanation.pdf)


## 3.2 EEG structure

**BehData Folder**: This folder contains the a subset of our data. The folders within `BehData` correspond to individual subjects. For example, folder UT014 contains the data for a subject with the unique subject code
`UT014`. The `UT` in the subject code indicates that the subject was enrolled in the study at the University of Texas, Southwestern. The subject number is 014. The UT subject codes follows the format `UT###` where the number indicates the number relative to the first subject enrolled in any of our studies at UT Southwestern. The first subject is UT001, the second subject is UT002 and so forth. Dr. Bradley Lega also collected data during his fellowship at the Cleveland Clinic. The subject code for these subjects follows the format `CC###`. For the purpose of this tutorial, you were only given data for `UT###` subjects. 

**Example Subject** in BehData Folder:
1. UT014
   This folder contains data for subject UT014.
   i. behavioral
      This folder contains the behavioral data for subject UT014. The contents of each subject folder are grouped by the experimental paradigm. This subject participated in 'acc reward', 'FR1', 'PS', 'pyFR stim', and 'YC1'. A brief description of the various paradigms is outlined in the Experimental Paradigms section of this document.
      A. FR1
         This folder contains all of the relevant behavioral files for subject UT014's free recall data.
         - events.mat: This file contains all of the events for subject UT014's FR1 data. Each row in the event corresponds to a single event within each FR1 session (e.g. the beginning of the session, a single word presentation, a spoken response from the subject). Each field of the events structure is outlined later in this section.
         - session 0: The events.mat file described above contains the events for all sessions combined. There are also individual session folders that contain the events only for one session. If you look inside the FR1 folder for UT014, you will see that there are 5 session folders (session 0, session 1, session 2, session 3, and session 4). This indicates that UT014 participated in 5 sessions of FR1. A full session of FR1 contains 25 lists of 12 words but a subject may also only complete a portion of a session.
   ii. eeg.noreref
       This folder typically contains the non-rereferenced EEG files for a subject. For this tutorial, we will instead be using the eeg.reref folder described below.
   iii. eeg.reref
       The eeg.reref folder contains the raw EEG files after being re-referenced to the weighted average of the activity at all other electrodes. For the purpose of this tutorial, you do not need to understand the specifics of this re-referencing. Each EEG filename is in the format of `[Subject Code] [Experimental Paradigm] [session number] [Date (DDMonthYY] [Military Time].[channel number]` or `[Subject Code] [Date (DDMonthYY] [Military Time].[channel number]`.Therefore, the file `UT014 02Sep15 1705.001` corresponds to the EEG file for subject `UT014` collected on `September 2, 2016 at 5:05 PM for electrode number 001`. There is usually one EEG file for each session for each electrode (i.e. EEG filename.001 to EEG filename.128 for channels 1 to 128). For the purpose of the tutorial, a subset of the channels are included. For subject UT014, we included channels `001, 002, 003, 042, 043 and 044`. These electrodes are all located in the hippocampus.


### 3.2.1 Description of Free Recall events.mat Fields

The EEG data collected from subjects in our lab is organized and formatted consistently using event structures, which are Matlab .mat files. These event structures contain various information about the task performed, including patient performance, task parameters, and most importantly, time offset values that align the EEG time with the Unix computer time when the event occurred. Below is a breakdown of the information included in the event structure for a Free-Recall (FR) task:

- **subject**: This field contains the subject code corresponding to the event in that row.
- **session**: This field specifies the session number for the event.
- **list**: This field specifies the list number within the corresponding session. For example, if a subject participated in 3 sessions, there will be 3 list #1s. If a subject completed 1 full session and 2 partial sessions, there may only be 1 list #25. For events that are not part of a list of words or recalls, the value is -999.
- **serialpos**: This field specifies the position of the word corresponding to the event in the corresponding list. The first word in list 1 will have a serial position of 1, the sixth word will have a serial position of 6, and so on. The eighth word of the eleventh list will have a serial position of 8 (within list 11).
- **type**: This field indicates the type of event. The possible entries are as follows:
  - B: Beginning of the EEG recording.
  - SESS START: Beginning of the session on the testing computer.
  - COUNTDOWN START: Beginning of the countdown from 10 to 0 that precedes each list.
  - COUNTDOWN END: End of the countdown that precedes each list.
  - PRACTICE WORD: Word presented during the first list of each session, which serves as a practice list.
  - PRACTICE DISTRACT START: Beginning of the distractor math problems for the practice list.
  - PRACTICE DISTRACT END: End of the distractor math problems for the practice list.
  - PRACTICE REC START: Beginning of the 30-second recall period for the practice list.
  - PRACTICE REC END: End of the recall period for the practice list.
  - TRIAL: Precedes any events for a new list.
  - ORIENT: Fixation point on the screen (+) that precedes the list of words after the countdown.
  - WORD: Presentation of a word on a test list (relevant for encoding analysis).
  - REC WORD: Vocalized response of a word during the recall period. These entries are manually scored by research assistants.
  - SESS END: Marks the end of the session.
  - E: Marks the end of the recordings.
- **item**: This field specifies the specific word that was presented or recalled. Entries that do not correspond to a presented or recalled word are marked as 'X'.
- **itemno**: This field specifies the number of the word presented or recalled from the word pool. Analyses can be performed using either the word number or the actual word entry in the 'item' field.
- **recalled**: This field contains -999 for entries that are not word presentations. For words that were presented and remembered, it has a value of 1. For words that were presented but not remembered, it has a value of 0.
- **intrusion**: Indicates whether the item was correctly recalled (intrusion == 0), a Prior List Intrusion (PLI) if intrusion > 0, or an Extra List Intrusion (ELI) if intrusion == -1.
- **eegfile**: This field points to the corresponding EEG file for that entry in the events structure. You will need to update this field to point to the location of the EEG files on your system. The filename should remain the same, but the folder location may need to be modified.
- **set**: This field specifies the number of milliseconds from the beginning of the EEG file where the event in that entry starts. This information is used by functions in the EEG toolbox to determine which segment of the EEG data to analyze for a specific event.

Understanding the organization and structure of the event structures is crucial for performing analyses on the EEG data. It allows researchers to extract the relevant information for specific conditions, events, or time points of interest during the encoding and retrieval periods of the memory task.

### 3.2.2 Free reacall behavioral results 

There is one event structure per for each subject. All sessions for the subject will be in the same event structure. The structure contains 688 entries in an array, each of which has these fields shown below.
Example of non-recalled word:

- `EVENTS.events(30)`
  - `subject`: 'UT004'     ---- UID for subject
  - `session`: 0           ---- session for this subject
  - `list`: 1           ---- which list of words (of 25 lists)
  - `serialpos`: 3           ---- which word (of 15 words/list)
  - `type`: 'WORD'      ---- word presented to subject
  - `item`: 'WHALE'     ---- which word
  - `itemno`: 137         ---- item from large list of items
  - `recalled`: 0           ---- Bool: 0=not recalled, 1=recalled
  - `mstime`: 1.4207e+12  ---time from beg of EEG recording(ms)
  - `msoffset`: 1           --- ??
  - `rectime`: -999        --- time the word was recalled
  - `intrusion`: -999        --- ??
  - `isStim`: 0           --- stim stuff that we don’t use 
  - `expVersion`: 'v_1.03'
  - `stimLoc`: 'X'
  - `stimAmp`: 1.5000
  - `stimAnode`: 82
  - `stimAnodeTag`: 'T'5'
  - `stimCathode`: 83
  - `stimCathodeTag`: 'T'6'
  - `stimList`: 1
  - `eegfile`: '/data10/RAM/subjects/UT004/eeg.reref/UT004_08Jan15_0902'
  - eeg file that corresponds to the epoch 
  - each channel is saved as a separate file 
  - suffix .1 = channel 1
  - Suffix .15 = channel 15
  - Anatomical location of these channels is coded in a separate structure
  - `eegoffset`: 1328198     --- # samples from beginning


Depth electrodes: Probes and the 10 contacts along the probes 
Surface electrodes: The cortical surface electrodes
Jacksheet gives a number to each electrode (e.g. between 1 to 150)
Another data structure details where the electrode was located in XYZ coord space, broadman area, and anatomical area
Depth electrodes in medial temporal lobe have been localized more precisely.

Events can be filtered by type.
Type:Recword is the event when the subject is speaking the word. When they begin to speak it. Manually labeled. 
13:24 
Example of successfully recalled word:
- `EVENTS.events(31)`
  - `subject`: 'UT004'
  - `session`: 0
  - `list`: 1
  - `serialpos`: 4
  - `type`: 'WORD'
  - `item`: 'HORSE'
  - `itemno`: 128
  - `recalled`: 1
  - `mstime`: 1.4207e+12
  - `msoffset`: 1
  - `rectime`: 14318
  - `intrusion`: -999
  - `isStim`: 1
  - `expVersion`: 'v_1.03'
  - `stimLoc`: 'X'
  - `stimAmp`: 1.5000
  - `stimAnode`: 82
  - `stimAnodeTag`: 'T'5'
  - `stimCathode`: 83
  - `stimCathodeTag`: 'T'6'
  - `stimList`: 1
  - `eegfile`: '/data10/RAM/subjects/UT004/eeg.reref/UT004_08Jan15_0902'
  - `eegoffset`: 1333095
Events for 20 subjects


**Encoding Period Analysis**: The goal of analyzing the encoding period is to identify differences in brain states that occur after the presentation of a stimulus or item. Typically, conditions in the encoding period are categorized as "Recalled" and "Non-recalled" based on the subject's later response to the item. The Recalled condition represents trials in which the subject later recalls the item, while the Non-recalled condition represents trials in which the subject does not recall the item.

**Retrieval Period Analysis**: Analyzing the retrieval period focuses on examining brain states before the recall of an item. Similar to the encoding period, conditions in the retrieval period are categorized as "Correctly Recalled" and "Incorrectly Recalled" (or "Intrusions"). The Correctly Recalled condition represents trials in which the subject accurately recalls the item, while the Incorrectly Recalled condition represents trials in which the subject recalls an incorrect item or makes an intrusion error.

To ensure clarity and facilitate effective communication, it is important to maintain consistent terminology when describing these conditions and their associated analysis methods. By using standardized terms, researchers can better explain and understand the specific analysis techniques employed in memory-related EEG studies.

## 3.3 Behavioral Analyses (Exercises)

### 3.3.1 Calculating Recall Probability 
In this first exercise, you will perform a simple behavioral analysis of free recall data. The probability of recall is simply the percentage of words that a subject remembered. You will first perform this analysis for one list for one subject. Once you are able to accomplish that, you will perform the analysis across all lists for one session for one subject. By the end of this exercise, you will be able to calculate the recall probability for across all sessions and all subjects. The steps necessary to perform these analyses are outlined below. As the exercises require you to calculate multiple recall probability, be sure to save the values out in an intuitive way that you can then work with later to average within a subject and then across all subjects.

**For following excercises, please note that the path `LegaLabTutorial/BehData/UT014/behavioral/FR1/events.mat` is assumed to be the correct path to the `events.mat` file.**

#### Probability of Recall for UT014 Session 0 List 1

The objective of this exercise is to familiarize you with the `events.mat` file used to filter experimental events. In this exercise, you will easily be able to check that your code is running properly by manually calculating the recall probability for a list and verifying that your manual calculation gives you the same result as your code.

1. Load the `events.mat` file located at `LegaLabTutorial/BehData/UT014/behavioral/FR1/events.mat`.
2. Extract the events for session 0 list 1 that have type 'WORD'.
3. Using the 'recalled' field in the events structure, find the total number of words that were recalled.
4. Count the total number of words that were presented for session 0 list 1.
5. To calculate the probability of recall, divide the number of words recalled by the number of words presented.
6. Save out the probability of recall for R1134T session 0 list 1.

#### Probability of Recall for UT014 Session 0 All Lists

This exercise should not require any skills beyond the skills used in the previous exercise. Because this exercise is over a larger set of data, it will be more difficult to manually check your work. This exercise should demonstrate why analyzing data is much more efficient using MATLAB.

1. Load the `events.mat` file located at `LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat`.
2. Extract the events for session 0 that have type 'WORD'.
3. Using the 'recalled' field in the events structure, find the total number of words that were recalled across all events for session 0.
4. Count the total number of words that were presented for session 0.
5. To calculate the probability of recall, divide the number of words recalled by the number of words presented during this session.
6. Save out the probability of recall for UT014 session 0.

#### Probability of Recall for UT014 All Sessions, All Lists

While there are many different ways to perform this analysis, one way to complete this exercise is using a 'for-loop'. You will want your code to check for the number of sessions and calculate a probability of recall for each session if a subject participated in more than one session. This exercise will also introduce you to plotting in MATLAB and calculating the standard error of the mean.

1. Load the `events.mat` file located at `LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat`.
2. Determine the number of sessions that R1158T participated in based on the unique entries in the 'session' field.
3. Loop through each session number.
4. Extract the events for the session you are looping for that have type 'WORD'.
5. Using the 'recalled' field in the events structure, find the total number of words that were recalled across all events for the session you are looping through.
6. Count the total number of words that were presented for that session.
7. To calculate the probability of recall, divide the number of words recalled by the number of words presented during that session.
8. Repeat until you have a recall probability for all sessions for UT014.
9. Create a labeled and titled barplot showing the recall probability for UT014.
   - The bar height should be the average of the recall probabilities for all sessions. You should also add error bars to the barplot. The error bar length should be 1 standard error of the mean (SEM). To calculate SEM, calculate the standard deviation of the recall probabilities across the sessions and divide the standard deviation by the sqrt(# sessions - 1). Because you cannot calculate a STD from 1 value and some subjects only participated in 1 session, it will be helpful to write your code so that the STD is only computed if there is more than 1 session.


#### Probability of Recall for All Subjects, All Sessions, and All Lists

This next exercise will require you to navigate through folders using MATLAB. One approach is to use the 'dir' function to get all of the folder names in the data folder. These will be the subject names. You will then loop through each subject, load the events structure for that subject, and calculate the probability of recall for each session that subject participated in. This will require more sophisticated use of strings to generate the unique filenames for each subject. This exercise will also introduce a new method of plotting data: the grouped bar plot.

1. Write code to dynamically find the subjects who have FR1 'events.mat' files. Your code should be able to work if a new subject is added to the folder without you having to change anything in your code.
2. Load the 'events.mat' file located at 'LegaLabTutorial/sampleData/[Subject]/behavioral/FR1/events.mat' for each subject.
3. Determine the number of sessions that each subject participated in based on the unique entries in the 'session' field.
4. Loop through each session number.
5. Extract the events for the session you are looping for that have type 'WORD'.
6. Using the 'recalled' field in the events structure, find the total number of words that were recalled across all events for the session you are looping through.
7. Count the total number of words that were presented for that session.
8. To calculate the probability of recall, divide the number of words recalled by the number of words presented during that session.
9. Repeat until you have a recall probability for all sessions for all subjects.
10. Create a grouped bar plot where there is one bar for each session for each subject. All sessions for a subject should be grouped together. The subject name will be on the x-axis, and the recall probability will be on the y-axis. There will be a separate bar for each session for each subject.
    - Because you are plotting the recall probability for each session, you do not need error bars for this figure.
    - Your plot should dynamically create the labels and groupings so that if another subject or session is added, the plot can be generated without having to change your code.
11. Plot a bar plot showing the average recall probability across all subjects. First, average the recall probability for each subject across all sessions. Then, compute the SEM and mean of the average recall probability. Plot error bars for the average recall probability across subjects. In your title, include the number of subjects that contributed to the average.

### 3.3.2 Generating Serial Position Curve

This exercise will guide you through how to generate a serial position curve (SPC). The SPC is the recall probability at each item output position. It shows how likely subjects were to remember a word at each position in the list, and it can reveal the primacy effect (higher recall probability for items at the beginning) and the recency effect (higher recall probability for items at the end). The SPC is calculated across multiple lists.

#### Serial Position Curve for UT014 Session 0

1. Load the 'events.mat' file located at 'LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat'.
2. Filter for events for session 0.
3. Count the number of words that were presented for each condition using the 'serialpos' field.
4. For each serial position, count the number of times that the word in that position was recalled using the 'recalled' field.
5. Calculate the percentage of words at each serial position that were recalled for this subject and session. You should have one probability for each serial position.
6. Plot the serial position curve for UT014 Session 0 as a line. Title and label your plot accordingly.

#### Serial Position Curve for UT014 All Sessions

1. Load the 'events.mat' file located at 'LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat'.
2. Loop through each session and calculate the recall probability at each serial position for each session.
3. Calculate the standard error of the mean (SEM) of the recall probability at each serial position and plot the serial position curve with error bars for this subject.

#### Serial Position Curve for All Subjects, All Sessions

1. Loop through each subject and load the 'events.mat' file for each subject.
2. Loop through each session for each subject and calculate the serial position curve for each session.
3. Average the serial position curves across sessions for each subject.
4. Plot the average serial position curve across subjects with SEM error bars. Include the number of subjects in the title of the plot.

### 3.3.3 Generating a Lag-Conditional Response Probability (CRP) Curve

This exercise will guide you through generating a lag-conditional response probability (CRP) curve, which measures how a subject moves from one response to another in a free recall dataset. The CRP curve is calculated by determining the number of times a subject could have had a particular response lag and the number of times the subject actually produced a response with that lag.

#### Lag-CRP for UT014 Session 0, List 1

1. Load the 'events.mat' file located at 'LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat'.
2. Filter for events for session 0, list 1.
3. Use events of type 'REC WORD' to determine the word a subject said and its order of presentation.
4. Filter for events that are of type 'REC WORD' with an 'itemno' greater than 0 and 'intrusion' equal to 0.
5. For each 'REC WORD', determine its serial position by comparing the 'itemno' with the 'itemno' of the 'WORD' events for the same list.
6. Calculate the possible lags and actual lags for each recalled word by considering the serial position and previously recalled words.
7. Generate the lag-CRP curve by dividing the number of times each transition was possible by the number of times it actually occurred.
8. Plot the lag-CRP curve for lags of -3, -2, -1, 1, 2, and 3 for UT014, session 0, list 1.

#### Lag-CRP for UT014 Session 0, All Lists

1. Load the 'events.mat' file located at 'LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat'.
2. Repeat the above exercise, considering all responses across all lists.
3. Plot the lag-CRP curve for the entire session.

#### Lag-CRP for UT014 All Sessions

1. Load the 'events.mat' file located at 'LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat'.
2. Loop through sessions and calculate a separate lag-CRP for each session.
3. Plot the lag-CRP curve for the average across sessions with SEM error bars.

#### Lag-CRP for All Subjects, All Sessions

1. Load the 'events.mat' file for each subject.
2. Repeat the above exercise for all subjects.
3. Average the CRP across sessions for each subject.
4. Plot the lag-CRP curve for the average across subjects showing SEM error bars.

Sure! Here's the information formatted in Markdown:

### Electrophysiological Analyses

In this section, you will learn how to analyze the EEG data collected during the behavioral task. This includes plotting raw voltage, calculating event-related potentials (ERP), baseline re-referencing, and generating average ERPs.

#### Plotting Raw Voltage

This exercise focuses on plotting the voltage recorded from one electrode for a single event.

- **Voltage for UT0145 ch 1, 1 Event**
  1. Load the events.mat file for UT014.
  2. Change the path in events.eegfile to point to the location of the EEG files on your computer.
  3. Extract the first event corresponding to word presentation (type 'WORD').
  4. Calculate the voltage for that event using a time window of 150 ms before word onset and 2000 ms after word onset with a buffer of 1000 ms. Filter out line-noise using a [58 62] Hz first-order 'stop' filter.
  5. Plot the voltage with the time relative to word onset on the x-axis. Indicate the word onset with a green vertical line and the word offset with a red vertical line.
  6. Label and title the plot appropriately specifying the subject, channel number, word presented, and sampling rate.

- **Voltage for UT014 ch 1, 1 Event with Resampling**
  1. Calculate the voltage for the same event and time window as above but now resample the data to 100 Hz.
  2. Plot the resampled voltage on the same plot as the voltage calculated above to compare the two traces.

#### Plotting Event-related Potential (ERP)

This exercise focuses on computing and plotting event-related potentials (ERP) for single and multiple channels.

- **Plotting the ERP for UT014, Channel 1 All Encoding Events**
  1. Filter the events.mat structure for UT014 for only the encoding events.
  2. Calculate the raw voltage for all these events.
  3. Find the mean and standard deviation of voltage across all events.
  4. Plot the ERP with error bars for this channel. Label and title the plot accordingly.

- **Plotting the ERP for 2 Channels for All Encoding Events for UT014**
  1. Calculate the ERP for channel 2 as done for channel 1 in the previous exercise.
  2. Plot the ERP with error bars for channel 2 and 1 on the same figure, labeling each channel.

- **Plotting the Baseline Re-referenced ERP for 2 Channels**
  1. Calculate the ERP for channels 1 and 2 as done in the previous exercise. Perform a baseline subtraction using the -150 ms to 0 ms baseline.
  2. Plot the baseline re-referenced ERP for each channel and label the plot accordingly.
  3. Add a horizontal line at y=0 to indicate the baseline. Clearly indicate the word onset and offset in the figure.

- **Plotting the Average ERP in the Hippocampus**
  1. Determine the electrodes you have EEG files for each subject.
  2. Loop through each electrode for each subject and calculate the ERP for all encoding events.
  3. Average the ERP across all electrodes for all subjects to generate an average ERP for the hippocampus.
  4. Plot the average hippocampal ERP with error bars.

Please note that the path in events.eegfile needs to be modified to point to the location of the EEG files on your computer.


Certainly! Here's the updated information with MATLAB code for each step:

```markdown
### Electrophysiological Analyses

In this section, you will learn how to analyze the EEG data collected during the behavioral task. This includes plotting raw voltage, calculating event-related potentials (ERP), baseline re-referencing, and generating average ERPs.

#### Plotting Raw Voltage

This exercise focuses on plotting the voltage recorded from one electrode for a single event.

- **Voltage for UT0145 ch 1, 1 Event**
  ```matlab
  % Load events.mat file for UT014
  load('LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat');

  % Change the path in events.eegfile to point to the EEG files on your computer
  events.eegfile = '/path/to/UT014/eeg.reref/UT01405Dec17_1545';

  % Extract the first event corresponding to word presentation
  event = events(strcmp({events.type}, 'WORD'), 1);

  % Calculate the voltage for that event
  voltage = gete_ms(event, 'filt',[58 62], 'buff',1000, 'tWin',[-150 2000]);

  % Plot the voltage
  figure;
  t = (-150:1:2000);  % Time vector
  plot(t, voltage);
  xlabel('Time (ms)');
  ylabel('Voltage (\muV)');
  title('Voltage for UT0145 ch 1, 1 Event');
  hold on;
  line([0 0], ylim, 'Color', 'g');  % Word onset (green line)
  line([1600 1600], ylim, 'Color', 'r');  % Word offset (red line)
  hold off;
  ```

- **Voltage for UT014 ch 1, 1 Event with Resampling**
  ```matlab
  % Calculate the voltage for the same event and time window with resampling
  voltage_resampled = resample(voltage, 100, 1000);  % Resample to 100 Hz

  % Plot the resampled voltage on the same plot
  hold on;
  plot(t, voltage_resampled);
  legend('Raw Voltage', 'Resampled Voltage');
  ```

#### Plotting Event-related Potential (ERP)

This exercise focuses on computing and plotting event-related potentials (ERP) for single and multiple channels.

- **Plotting the ERP for UT014, Channel 1 All Encoding Events**
  ```matlab
  % Filter events.mat structure for UT014 encoding events
  encoding_events = events(strcmp({events.type}, 'WORD'));

  % Calculate the raw voltage for all encoding events
  voltage_all = gete_ms(encoding_events, 'filt',[58 62], 'buff',1000, 'tWin',[-150 2000]);

  % Compute mean and standard deviation of voltage across all events
  mean_voltage = mean(voltage_all);
  std_voltage = std(voltage_all);

  % Plot the ERP with error bars
  figure;
  errorbar(t, mean_voltage, std_voltage);
  xlabel('Time (ms)');
  ylabel('Voltage (\muV)');
  title('ERP for UT014, Channel 1 All Encoding Events');
  ```

- **Plotting the ERP for 2 Channels for All Encoding Events for UT014**
  ```matlab
  % Calculate the ERP for channel 2
  voltage_channel2 = gete_ms(encoding_events, 'filt',[58 62], 'buff',1000, 'tWin',[-150 2000], 'ch',2);

  % Plot the ERPs for channel 1 and channel
  