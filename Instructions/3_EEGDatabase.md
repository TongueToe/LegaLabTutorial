# 3-EEG_database

# Table of Content
- [3-EEG_database](#3-eeg_database)
  - [3.1 Behavioral-Tasks](#31-behavioral-tasks)
    - [Experimental Paradigms](#experimental-paradigms)
  - [3.2 EEG structure](#32-eeg-structure)
    - [3.2.1 Description of Free Recall events.mat Fields](#321-description-of-free-recall-eventsmat-fields)
    - [3.2.2 Free recall behavioral results](#322-free-reacall-behavioral-results)
  - [3.3 Behavioral Analyses (Exercises)](#33-behavioral-analyses-exercises)
    - [3.3.1 Calculating Recall Probability](#331-calculating-recall-probability)
    - [3.3.2 Generating Serial Position Curve](#332-generating-serial-position-curve)
    - [3.3.3 Generating a Lag-Conditional Response Probability (CRP) Curve](#333-generating-a-lag-conditional-response-probability-crp-curve)
    - [3.3.4 Electrophysiological Analyses](#334-electrophysiological-analyses)
      - [3.3.4.1 Plotting Raw Voltage](#3341-plotting-raw-voltage)
      - [3.3.4.2 Plotting Event-related Potential (ERP)](#3342-plotting-event-related-potential-erp)

## 3.1 Behavioral-Tasks

General Task Descriptions:
- **FR Task**: In a free-recall task, a participant studies a list of words for a later recall test. The words are presented one at a time. Then after all the words are shown, the participant attempts to recall the words from the list in any order. A key feature of free recall is that the participant is allowed to recall the list items in any order. Thus, the analysis of the order in which a participant recalls the list items may give clues as to the underlying mechanisms of memory search. In particular, we may ask what factors determine the order in which participants recall words from the list, how these factors interact to determine whether a given item is recalled, and, in the end, how many items are actually recalled.
Experimental Paradigms:
- **AR Task**: Laboratory studies of associative memory are concerned with people’s ability to encode a relation between two items, including the ability to later use one of the items as a cue to retrieve the other item.
In considering associative tasks, we not only explore how people forge a memory representation that combines or links information from two previously learned representations, but we also investigate associative recall: the ability of a cue item to help people recall a target item. Thus, we add two new dimensions beyond our prior analysis (i.e.: free recall) of recognition memory for items: the dimensions of association and recall.
In general, associations being studied are links connecting two distinct knowledge representations. More specifically, these associations are new representations that combine elements of the constituent item representations. When studying these associations, it is important to consider situational and temporal context.
Experimentation is comprised of multiple study and task sections. In the study and encoding phase – participants will see pairs of words on screen and attempt to form associations. During test, participants will categorize them as new, rearranged, or same pairs.
•	See slides below for visual representation of AR Task 
- **SR Task**: Serial recall is the method for studying memory for sequentially ordered materials. Participants study a ordered list of items presented to them individually, and are tasked with recalling the exact sequence of said items. Conditions of this task allow us to study the encoding and retrieval phases of memory.
- [Kahana, M. J. (2012). Foundations of human memory. Oxford University Press.]

Experimental Paradigms:

- **FR1**: Verbal free recall paradigm for the RAM project.
- **FR2**: Similar to FR1, but stimulation is delivered on random words within each list.
- **pyFR**: Free recall paradigm similar to FR1, with minor differences in list length, recall duration, and number of lists (python).
- **pyFR stim**: Similar to pyFR, but stimulation is delivered during entire lists. For some subjects, stimulation was delivered during the entire encoding period or the entire recall period.
- **AccRew**: Reward processing task.
- **PS2/PS3**: Tasks where stimulation is delivered with varying parameters (amplitude, frequency, duration, location) without any behavioral tasks.
- **catFR1**: Similar to FR1, but the words within each list fall into category groupings (e.g., Animals: dog, cat, fish; Fruits: apple, orange, pear; Tools: saw, drill, hammer).
- **catFR2**: Similar to catFR1, but with added stimulation.
- **YC1**: Spatial navigation task.
- **YC2**: Similar to YC1, but with stimulation.
- **PAL1**: Paired-associate task where subjects have to remember a word from a pair of words instead of just any word from a list.
- **PAL2**: Similar to PAL1, but with added stimulation.
- **AR1**: Associative Recognition. Visual explanation of AR task: [AR Task](../src/ar_task_explanation.pdf)
- **AR stim**: Similar to associative recognition, but stimulation is used.
- **SR**: Verbal serial recall paradigm.

## 3.2 EEG structure

**BehData Folder**: This folder contains the a subset of our data. The folders within `BehData` correspond to individual subjects. For example, folder UT014 contains the data for a subject with the unique subject code
`UT014`. The `UT` in the subject code indicates that the subject was enrolled in the study at the University of Texas, Southwestern. The subject number is 014. The UT subject codes follows the format `UT###` where the number indicates the number relative to the first subject enrolled in any of our studies at UT Southwestern. The first subject is UT001, the second subject is UT002 and so forth. Dr. Bradley Lega also collected data during his fellowship at the Cleveland Clinic. The subject code for these subjects follows the format `CC###`. For the purpose of this tutorial, you were only given data for `UT###` subjects. 

**Example Subjects** in BehData Folder:
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

2. UT104
   This folder contains data for subject UT104.
3. UT340
   This folder contains data for subject UT340. 

### 3.2.1 Description of Free Recall events.mat Fields

The EEG data collected from subjects in our lab is organized and formatted consistently using event structures, which are Matlab .mat files. These event structures contain various information about the task performed, including patient performance, task parameters, and most importantly, time offset values that align the EEG time with the Unix computer time when the event occurred. Below is a breakdown of the information included in the event structure for a *Free-Recall (FR) task*:

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

While the event structures for the Associative-Recall (AR) task are organized and contain similar information to the FR task, there are unique features attributed to AR related to the rearrangement aspect of the test. Below is a breakdown of the information included in the event structure for an *AR task*:
- **Subject**: This field contains the subject code corresponding to the event in that row.
- **mstime**: This field provides the task computer time when the row event happened in milliseconds.
- **event**: This field provides information regarding the stage of the trial being executed, distinguishing between encoding and retrieval phases, or indicating the completion of a specific block.
- **correct_ans**: This field denotes the expected ideal response, represented as an integer (with 1 indicating the top word, 2 indicating the bottom word, and -999 indicating non-applicability).
- **Response**: This field provides the subject’s inputted response
- **Correct**: This field provides an integer value representing whether the response matches the correct_ans (1 indicates a match, 0 indicates no match).
- **mstime_toRes**: This field indicates the duration between the presentation of a pair of words on the screen and the subsequent button press by the participant, indicating the time taken to respond in milliseconds
- **wp**: This field provides the word-pair being tested. The first one listed is the top word in the pair, and the second is the bottom word in the pair.
- **Rearrange**: This field is a logical integer variable that represents whether or not the word pair in question was rearranged or not, in both the encoding and retrieval sections.
- **correct_opp_1**: This field assigns a value to the top word in the word pair, and tests whether or not the subject was able to accurately categorize the word in the new setting.
- **correct_opp_2**: For example, when words are rearranged, correct_opp_2 would represent whether the word pair that contained the bottom word was correctly classified as rearranged by the subject
- **retrieval_ans_1**: This field provides the subject’s answer to the rearranged pair that included the top word, based on answer to study part of the experiment.
- **retrieval_ans_2**: This field does the same for the bottom word in the pair.
- **Eegfile**: This field points to the corresponding EEG file for that entry in the events structure. You will need to update this field to point to the location of the EEG files on your system. The filename should remain the same, but the folder location may need to be modified.
- **eegoffset**: This field denotes the difference between the time frames of the eeg and computer recordings in milliseconds.

When the AR Task includes *stimulation*, there are a few more event fields that will be used:
-	**Block**: This field denotes the section of experiment (practice, section number, etc.)
-	**Retr_stim**: This field provides an integer value of 0 or 1 which represents whether or not there was stimulation in that word pair.
-	**Stim_elec**: This field provides a label of the channel that was stimulated.
-	**Stim_mamp**: This field provides the stimulation amplitude in milliamperes.
-	**Stim_hz**: This field provides the stimulation amplitude in hertz.
-	**Log_num**: This field provides the number of the event that was logged.
-	**Log_time**: This field provides the test computer time in which the event was logged.
-	**Sec_time**: This field provides the time in seconds in which the event was logged.
-	**Study_ans**: This field provides information on whether the answer is top or bottom
-	**Test_ans**: This field provides information on whether the pair being presented is the same, new, or rearranged pair

Serial recall includes its own set of unique features as well. Below is a breakdown of the information unique to the event structure for the *Serial Recall* task. Any variables seen in the SR events.mat files not included below will be described in a previous section.
-	**List**: This field specifies the list number within the corresponding session (see previous description). For SR, if the experiment is divided into multiple lists with a study and test sections, 0 would be the practice list.
-	**Type**: This field indicates the type of event. The possible entries are as follows:
    WORD: An item in the list to be remembered by subject.
    REC_START: When test portion of serial recall starts.
    REC_STOP: When test portion of serial recall ends.
    ORIENT: Fixation cross displayed at the center of the screen.
-	**Item**: This field specifies the specific word that was presented or recalled. Entries that do not correspond to a presented or recalled word are marked as 'X'.
-	**Loc_x**: This field denotes where on the screen (x axis) the word is positioned
-	**Loc_y**: This field denotes where on the screen (y axis) the word is positioned.

The loc_x and loc_y values are used to identify the order the subject placed the words in.

-	**Serialpos**: This field provides the actual serial position of the word in question (1-10)
-	**Decode_serialpos**: This field provides the subject interpretation of the serial position of the word based on where subject placed the word.
-	**Correct**: This field provides an integer based on a comparison between decode_serialpos and serialpos (1 represents a correct answer and match, 0 represents an incorrect answer)
-	**Dist_correct**: This field describes the accuracy of the subject’s answer in terms of their answer’s distance from the correct answer (formula: decode_serialpos – serialpos)
-	**Log_time**: This field provides the test computer time in which the event happened or ended, corresponding to each word by serial position.
-	**Dur**: This field provides how long the word was displayed on the screen, and how long the orient lasted in seconds.
-	**Log_num**: This field provides the order in which the events were logged.
-	**Order**: This field is a representation of the type of event (2 is orient, 3 is word, 4 is rec start, 5 is rec stop)
-	Sec_error:  ?
-	Sec_time: (?) The time in which the words are first scattered on screen
-	**Eegoffset**: We have a computer logged time event/sync pulses. Times when sync pulses are recorded on the computer and eeg recording, correlation is done that minimizes the error to match sync pulses (ms).


Understanding the organization of the event structures is crucial for performing analyses on the EEG data. It allows researchers to extract the relevant information for specific conditions, events, or time points of interest during the encoding and retrieval periods of the memory task.

### 3.2.2 Subject Example Behavioral Results 

*Free Recall*
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

*Serial Recall*
Example of incorrectly placed word:
- `EVENTS.events(30)`
  - `subject`: 'UT140'     ---- UID for subject
   - `list`: 0           ---- which list of words (of 25 lists)
  - `type`: 'REC_STOP'      ---- test portion identified
  - `item`: 'ROAD'     ---- which word
  - `loc_x`: 1.2665e+03           ---- horizontal location
  - `loc_y`: 1.3010e+03           ---- vertical location
  - `serialpos`: 9           ---- which word (of 10 words/list)
  - `decode_serialpos`: 5         ---- subject interpretation of word’s serial position
  - `correct`: 0           ---- 0=not correct, 1=correct
  - `dist_correct `: -4  --- distance from correct word 
  - `log_time`: 1.0114e+05           --- test computer time recorded
  - `dur`: NaN        --- time the word was displayed
  - `order`: 0           --- corresponds to type 
  - `eegfile`: '/project/TIBIR/Lega_lab/shared/lega_ansir/subjFiles/UT340/eeg.reref/UT340_SR1_0_02Feb23_1142'
  - eeg file that corresponds to the epoch 
  - `eegoffset`: 505809     --- # samples from beginning

## 3.3 Behavioral Analyses (Exercises)

### 3.3.1 Calculating Recall Probability 
In this first exercise, you will perform a simple behavioral analysis of free recall data. The probability of recall is simply the percentage of words that a subject remembered. You will first perform this analysis for one list for one subject. Once you are able to accomplish that, you will perform the analysis across all lists for one session for one subject. By the end of this exercise, you will be able to calculate the recall probability for across all sessions and all subjects. The steps necessary to perform these analyses are outlined below. As the exercises require you to calculate multiple recall probability, be sure to save the values out in an intuitive way that you can then work with later to average within a subject and then across all subjects.

**For following excercises, please note that the path `LegaLabTutorial/BehData/UT014/behavioral/FR1/events.mat` is assumed to be the correct path to the `events.mat` file.**

-**Probability of Recall for UT014 Session 0 List 1**

  The objective of this exercise is to familiarize you with the `events.mat` file used to filter experimental events. In this exercise, you will easily be able to check that your code is running properly by manually calculating the recall probability for a list and verifying that your manual calculation gives you the same result as your code.

  1. Load the `events.mat` file located at `LegaLabTutorial/BehData/UT014/behavioral/FR1/events.mat`.
  2. Extract the events for session 0 list 1 that have type 'WORD'.
  3. Using the 'recalled' field in the events structure, find the total number of words that were recalled.
  4. Count the total number of words that were presented for session 0 list 1.
  5. To calculate the probability of recall, divide the number of words recalled by the number of words presented.
  6. Save out the probability of recall for R1134T session 0 list 1.

  ```matlab
  % Probability of Recall for UT014 Session 0 List 1
  load('LegaLabTutorial/BehData/UT014/behavioral/FR1/events.mat');

  % Extract events for session 0 list 1 with type 'WORD'
  session0_list1_events = events([events.session] == 0 & [events.list] == 1 & strcmp({events.type}, 'WORD'));

  % Count the number of words recalled
  num_words_recalled = sum([session0_list1_events.recalled]);

  % Count the total number of words presented
  num_words_presented = sum(strcmp({session0_list1_events.type}, 'WORD'));

  % Calculate the probability of recall
  recall_probability = num_words_recalled / num_words_presented;

  % Save the probability of recall for UT014 Session 0 List 1
  save('UT014_Session0_List1_RecallProbability.mat', 'recall_probability');
  ```

-**Probability of Recall for UT014 Session 0 All Lists**

  This exercise should not require any skills beyond the skills used in the previous exercise. Because this exercise is over a larger set of data, it will be more difficult to manually check your work. This exercise should demonstrate why analyzing data is much more efficient using MATLAB.

  1. Load the `events.mat` file located at `LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat`.
  2. Extract the events for session 0 that have type 'WORD'.
  3. Using the 'recalled' field in the events structure, find the total number of words that were recalled across all events for session 0.
  4. Count the total number of words that were presented for session 0.
  5. To calculate the probability of recall, divide the number of words recalled by the number of words presented during this session.
  6. Save out the probability of recall for UT014 session 0.

  ```matlab
  % Probability of Recall for UT014 Session 0 All Lists
  load('LegaLabTutorial/BehData/UT014/behavioral/FR1/events.mat');

  % Extract events for session 0 with type 'WORD'
  session0_events = events([events.session] == 0 & strcmp({events.type}, 'WORD'));

  % Count the number of words recalled
  num_words_recalled = sum([session0_events.recalled]);

  % Count the total number of words presented
  num_words_presented = sum(strcmp({session0_events.type}, 'WORD'));

  % Calculate the probability of recall
  recall_probability = num_words_recalled / num_words_presented;

  % Save the probability of recall for UT014 Session 0 All Lists
  save('UT014_Session0_AllLists_RecallProbability.mat', 'recall_probability');
  ```

-**Probability of Recall for UT014 All Sessions, All Lists**

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
  ```matlab
  % Probability of Recall for UT014 All Sessions, All Lists
  load('LegaLabTutorial/BehData/UT014/behavioral/FR1/events.mat');

  % Determine the number of sessions for UT014
  num_sessions = max([events.session]);

  recall_probability_sessions = zeros(num_sessions, 1);

  for session = 1:num_sessions
      % Extract events for the current session with type 'WORD'
      session_events = events([events.session] == session & strcmp({events.type}, 'WORD'));
      
      % Count the number of words recalled
      num_words_recalled = sum([session_events.recalled]);
      
      % Count the total number of words presented
      num_words_presented = sum(strcmp({session_events.type}, 'WORD'));
      
      % Calculate the probability of recall for the current session
      recall_probability_sessions(session) = num_words_recalled / num_words_presented;
  end

  % Save the probability of recall for UT014 All Sessions, All Lists
  save('UT014_AllSessions_AllLists_RecallProbability.mat', 'recall_probability_sessions');
  ```

-**Probability of Recall for All Subjects, All Sessions, and All Lists**

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

  ```maltab 
  % Probability of Recall for All Subjects, All Sessions, and All Lists
  data_folder = 'LegaLabTutorial/BehData';

  % Get the list of subject folders
  subject_folders = dir(data_folder);
  subject_folders = subject_folders(~ismember({subject_folders.name}, {'.', '..'}));

  recall_probability_subjects = cell(numel(subject_folders), 1);

  for subject_idx = 1:numel(subject_folders)
      subject_name = subject_folders(subject_idx).name;
      
      % Get the list of session folders for the current subject
      session_folders = dir(fullfile(data_folder, subject_name, 'behavioral/FR1'));
      session_folders = session_folders(~ismember({session_folders.name}, {'.', '..'}));
      
      recall_probability_sessions = zeros(numel(session_folders), 1);
      
      for session_idx = 1:numel(session_folders)
          session_name = session_folders(session_idx).name;
          
          % Load the events for the current session
          events_file = fullfile(data_folder, subject_name, 'behavioral/FR1', session_name, 'events.mat');
          load(events_file);
          
          % Extract events with type 'WORD'
          session_events = events(strcmp({events.type}, 'WORD'));
          
          % Count the number of words recalled
          num_words_recalled = sum([session_events.recalled]);
          
          % Count the total number of words presented
          num_words_presented = sum(strcmp({session_events.type}, 'WORD'));
          
          % Calculate the probability of recall for the current session
          recall_probability_sessions(session_idx) = num_words_recalled / num_words_presented;
      end
      
      % Save the probability of recall for the current subject
      recall_probability_subjects{subject_idx} = recall_probability_sessions;
  end

  % Save the probability of recall for All Subjects, All Sessions, and All Lists
  save('AllSubjects_AllSessions_AllLists_RecallProbability.mat', 'recall_probability_subjects');
  ```

### 3.3.2 Generating Serial Position Curve

This exercise will guide you through how to generate a serial position curve (SPC). The SPC is the recall probability at each item output position. It shows how likely subjects were to remember a word at each position in the list, and it can reveal the primacy effect (higher recall probability for items at the beginning) and the recency effect (higher recall probability for items at the end). The SPC is calculated across multiple lists.

- **Serial Position Curve for UT014 Session 0**

  1. Load the 'events.mat' file located at 'LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat'.
  2. Filter for events for session 0.
  3. Count the number of words that were presented for each condition using the 'serialpos' field.
  4. For each serial position, count the number of times that the word in that position was recalled using the 'recalled' field.
  5. Calculate the percentage of words at each serial position that were recalled for this subject and session. You should have one probability for each serial position.
  6. Plot the serial position curve for UT014 Session 0 as a line. Title and label your plot accordingly.

  **Example codes**
  ```matlab
  % Serial Position Curve for UT014 Session 0
  load('LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat');

  % Filter for events for session 0
  session0_events = events([events.session] == 0);

  % Count the number of words presented for each condition
  num_words_presented = histcounts([session0_events.serialpos], 1:13);

  % Count the number of times each word was recalled
  num_words_recalled = histcounts([session0_events([session0_events.recalled]).serialpos], 1:13);

  % Calculate the recall probability at each serial position
  recall_probability = num_words_recalled ./ num_words_presented;

  % Plot the serial position curve for UT014 Session 0
  figure;
  plot(1:12, recall_probability, 'o-');
  xlabel('Serial Position');
  ylabel('Recall Probability');
  title('Serial Position Curve for UT014 Session 0');
  ```
- **Serial Position Curve for UT014 All Sessions**

  1. Load the 'events.mat' file located at 'LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat'.
  2. Loop through each session and calculate the recall probability at each serial position for each session.
  3. Calculate the standard error of the mean (SEM) of the recall probability at each serial position and plot the serial position curve with error bars for this subject.
  
  **Example codes**
  ```matlab
  % Serial Position Curve for UT014 All Sessions
  load('LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat');

  sessions = unique([events.session]);
  recall_probability_all_sessions = zeros(numel(sessions), 12);

  for i = 1:numel(sessions)
      session_events = events([events.session] == sessions(i));
      num_words_presented = histcounts([session_events.serialpos], 1:13);
      num_words_recalled = histcounts([session_events([session_events.recalled]).serialpos], 1:13);
      recall_probability_all_sessions(i, :) = num_words_recalled(1:12) ./ num_words_presented(1:12);
  end

  mean_recall_probability = mean(recall_probability_all_sessions);
  sem_recall_probability = std(recall_probability_all_sessions) ./ sqrt(numel(sessions));

  figure;
  errorbar(1:12, mean_recall_probability, sem_recall_probability);
  xlabel('Serial Position');
  ylabel('Recall Probability');
  title('Serial Position Curve for UT014 All Sessions');
  ```
- **Serial Position Curve for All Subjects, All Sessions**

  1. Loop through each subject and load the 'events.mat' file for each subject.
  2. Loop through each session for each subject and calculate the serial position curve for each session.
  3. Average the serial position curves across sessions for each subject.
  4. Plot the average serial position curve across subjects with SEM error bars. Include the number of subjects in the title of the plot.
  
  **Example codes**
  ```matlab
  % Serial Position Curve for All Subjects, All Sessions
  subjects = {'UT014', 'Subject2', 'Subject3'}; % Add subject names
  num_subjects = numel(subjects);

  recall_probability_all_subjects = zeros(num_subjects, 12);

  for s = 1:num_subjects
      load(['LegaLabTutorial/sampleData/', subjects{s}, '/behavioral/FR1/events.mat']);
      sessions = unique([events.session]);
      recall_probability_all_sessions = zeros(numel(sessions), 12);
      
      for i = 1:numel(sessions)
          session_events = events([events.session] == sessions(i));
          num_words_presented = histcounts([session_events.serialpos], 1:13);
          num_words_recalled = histcounts([session_events([session_events.recalled]).serialpos], 1:13);
          recall_probability_all_sessions(i, :) = num_words_recalled(1:12) ./ num_words_presented(1:12);
      end
      
      recall_probability_all_subjects(s, :) = mean(recall_probability_all_sessions);
  end

  mean_recall_probability_all_subjects = mean(recall_probability_all_subjects);
  sem_recall_probability_all_subjects = std(recall_probability_all_subjects) ./ sqrt(num_subjects);

  figure;
  errorbar(1:12, mean_recall_probability_all_subjects, sem_recall_probability_all_subject
  ```

### 3.3.3 Generating a Lag-Conditional Response Probability (CRP) Curve

This exercise will guide you through generating a lag-conditional response probability (CRP) curve, which measures how a subject moves from one response to another in a free recall dataset. The CRP curve is calculated by determining the number of times a subject could have had a particular response lag and the number of times the subject actually produced a response with that lag.

- **Lag-CRP for UT014 Session 0, List 1**

  1. Load the 'events.mat' file located at 'LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat'.
  2. Filter for events for session 0, list 1.
  3. Use events of type 'REC WORD' to determine the word a subject said and its order of presentation.
  4. Filter for events that are of type 'REC WORD' with an 'itemno' greater than 0 and 'intrusion' equal to 0.
  5. For each 'REC WORD', determine its serial position by comparing the 'itemno' with the 'itemno' of the 'WORD' events for the same list.
  6. Calculate the possible lags and actual lags for each recalled word by considering the serial position and previously recalled words.
  7. Generate the lag-CRP curve by dividing the number of times each transition was possible by the number of times it actually occurred.
  8. Plot the lag-CRP curve for lags of -3, -2, -1, 1, 2, and 3 for UT014, session 0, list 1.

  **Example codes** 
  ```matlab
  % Lag-CRP for UT014 Session 0, List 1
  load('LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat');
  events.eegfile = '/path/to/UT014/eeg.reref/UT01405Dec17_1545';

  % Filter for events for session 0, list 1
  session0_list1_events = events([events.session] == 0 & [events.list] == 1);

  % Filter for REC WORD events with itemno > 0 and intrusion == 0
  rec_word_events = session0_list1_events(strcmp({session0_list1_events.type}, 'REC WORD') & [session0_list1_events.itemno] > 0 & [session0_list1_events.intrusion] == 0);

  % Determine the serial position for each recalled word
  serial_positions = NaN(1, numel(rec_word_events));
  for i = 1:numel(rec_word_events)
      itemno = rec_word_events(i).itemno;
      word_events = session0_list1_events(strcmp({session0_list1_events.type}, 'WORD') & [session0_list1_events.itemno] == itemno);
      serial_positions(i) = word_events(1).serialpos;
  end

  % Calculate the possible lags and actual lags
  possible_lags = NaN(1, numel(rec_word_events));
  actual_lags = NaN(1, numel(rec_word_events));
  for i = 1:numel(rec_word_events)
      serial_pos = serial_positions(i);
      possible_lags(i) = 1 - serial_pos : numel(session0_list1_events) - serial_pos;
      if i > 1
          prev_recalled_words = serial_positions(1:i-1);
          actual_lags(i) = serial_pos - prev_recalled_words(end);
      end
  end

  % Calculate the lag-CRP curve
  lag_crp = NaN(1, numel(possible_lags));
  for i = 1:numel(possible_lags)
      lag = possible_lags(i);
      lag_crp(i) = sum(actual_lags == lag) / numel(find(possible_lags == lag));
  end

  % Plot the lag-CRP curve for lags of -3, -2, -1, 1, 2, and 3
  lags = [-3, -2, -1, 1, 2, 3];
  figure;
  bar(lags, lag_crp(lags + 4));
  xlabel('Lag');
  ylabel('CRP');
  title('Lag-CRP for UT014 Session 0, List 1');
  ```
- **Lag-CRP for UT014 Session 0, All Lists**

  1. Load the 'events.mat' file located at 'LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat'.
  2. Repeat the above exercise, considering all responses across all lists.
  3. Plot the lag-CRP curve for the entire session.
  **Example codes** 
  ```matlab 
  % Lag-CRP for UT014 Session 0, All Lists
  all_lists_events = events([events.session] == 0);
  rec_word_events_all_lists = all_lists_events(strcmp({all_lists_events.type}, 'REC WORD') & [all_lists_events.itemno] > 0 & [all_lists_events.intrusion] == 0);
  serial_positions_all_lists = NaN(1, numel(rec_word_events_all_lists));
  for i = 1:numel(rec_word_events_all_lists)
      itemno = rec_word_events_all_lists(i).itemno;
      word_events = all_lists_events(strcmp({all_lists_events.type}, 'WORD') & [all_lists_events.itemno] == itemno);
      serial_positions_all_lists(i) = word_events(1).serialpos;
  end
  possible_lags_all_lists = NaN(1, numel(rec_word_events_all_lists));
  actual_lags_all_lists = NaN(1, numel(rec_word_events_all_lists));
  for i = 1:numel(rec_word_events_all_lists)
      serial_pos = serial_positions_all_lists(i);
      possible_lags_all_lists(i) = 1 - serial_pos : numel(all_lists_events) - serial_pos;
      if i > 1
          prev_recalled_words = serial_positions_all_lists(1:i-1);
          actual_lags_all_lists(i) = serial_pos - prev_recalled_words(end);
      end
  end
  lag_crp_all_lists = NaN(1, numel(possible_lags_all_lists));
  for i = 1:numel(possible_lags_all_lists)
      lag = possible_lags_all_lists(i);
      lag_crp_all_lists(i) = sum(actual_lags_all_lists == lag) / numel(find(possible_lags_all_lists == lag));
  end
  figure;
  bar(lags, lag_crp_all_lists(lags + 4));
  xlabel('Lag');
  ylabel('CRP');
  title('Lag-CRP for UT014 Session 0, All Lists');
  ```
  
- **Lag-CRP for UT014 All Sessions**

  1. Load the 'events.mat' file located at 'LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat'.
  2. Loop through sessions and calculate a separate lag-CRP for each session.
  3. Plot the lag-CRP curve for the average across sessions with SEM error bars.

  **Example codes** 
  ```matlab
    % Lag-CRP for UT014 All Sessions
  sessions = unique([events.session]);
  lag_crp_all_sessions = NaN(numel(sessions), numel(lags));
  for s = 1:numel(sessions)
      session_events = events([events.session] == sessions(s));
      rec_word_events_session = session_events(strcmp({session_events.type}, 'REC WORD') & [session_events.itemno] > 0 & [session_events.intrusion] == 0);
      serial_positions_session = NaN(1, numel(rec_word_events_session));
      for i = 1:numel(rec_word_events_session)
          itemno = rec_word_events_session(i).itemno;
          word_events = session_events(strcmp({session_events.type}, 'WORD') & [session_events.itemno] == itemno);
          serial_positions_session(i) = word_events(1).serialpos;
      end
      possible_lags_session = NaN(1, numel(rec_word_events_session));
      actual_lags_session = NaN(1, numel(rec_word_events_session));
      for i = 1:numel(rec_word_events_session)
          serial_pos = serial_positions_session(i);
          possible_lags_session(i) = 1 - serial_pos : numel(session_events) - serial_pos;
          if i > 1
              prev_recalled_words = serial_positions_session(1:i-1);
              actual_lags_session(i) = serial_pos - prev_recalled_words(end);
          end
      end
      lag_crp_session = NaN(1, numel(possible_lags_session));
      for i = 1:numel(possible_lags_session)
          lag = possible_lags_session(i);
          lag_crp_session(i) = sum(actual_lags_session == lag) / numel(find(possible_lags_session == lag));
      end
      lag_crp_all_sessions(s, :) = lag_crp_session(lags + 4);
  end
  mean_lag_crp_sessions = mean(lag_crp_all_sessions);
  sem_lag_crp_sessions = std(lag_crp_all_sessions) / sqrt(numel(sessions));
  figure;
  errorbar(lags, mean_lag_crp_sessions, sem_lag_crp_sessions);
  xlabel('Lag');
  ylabel('CRP');
  title('Lag-CRP for UT014 All Sessions');
  ```
- **Lag-CRP for All Subjects, All Sessions**

  1. Load the 'events.mat' file for each subject.
  2. Repeat the above exercise for all subjects.
  3. Average the CRP across sessions for each subject.
  4. Plot the lag-CRP curve for the average across subjects showing SEM error bars.



### 3.3.4 Electrophysiological Analyses

In this section, you will learn how to analyze the EEG data collected during the behavioral task. This includes plotting raw voltage, calculating event-related potentials (ERP), baseline re-referencing, and generating average ERPs.

#### 3.3.4.1 Plotting Raw Voltage

This exercise focuses on plotting the voltage recorded from one electrode for a single event.

- **Voltage for UT0145 ch 1, 1 Event**
  1. Load the events.mat file for UT014.
  2. Change the path in events.eegfile to point to the location of the EEG files on your computer.
  3. Extract the first event corresponding to word presentation (type 'WORD').
  4. Calculate the voltage for that event using a time window of 150 ms before word onset and 2000 ms after word onset with a buffer of 1000 ms. Filter out line-noise using a [58 62] Hz first-order 'stop' filter.
  5. Plot the voltage with the time relative to word onset on the x-axis. Indicate the word onset with a green vertical line and the word offset with a red vertical line.
  6. Label and title the plot appropriately specifying the subject, channel number, word presented, and sampling rate.
  ```matlab 
  % Voltage for UT0145 ch 1, 1 Event
  load('LegaLabTutorial/sampleData/UT014/behavioral/FR1/events.mat');

  % Change the path in events.eegfile to point to the location of the EEG files on your computer

  % Extract the first event corresponding to word presentation (type 'WORD')
  event_idx = find(strcmp({events.type}, 'WORD'), 1);

  % Load the EEG data for the event
  eeg_data = load(events(event_idx).eegfile);

  % Calculate the voltage for the event with the specified time window and filtering
  voltage = getems(eeg_data.data, eeg_data.srate, events(event_idx).eegoffset, events(event_idx).eegoffset + events(event_idx).eeglength, [-1000, 1000], [58 62], 'stop');

  % Create a time vector relative to word onset
  time = (-1000:1000) / eeg_data.srate;

  % Plot the voltage with time relative to word onset
  figure;
  plot(time, voltage);

  % Add vertical lines to indicate word onset and offset
  hold on;
  word_onset = events(event_idx).eegoffset / eeg_data.srate;
  word_offset = (events(event_idx).eegoffset + events(event_idx).eeglength) / eeg_data.srate;
  line([word_onset, word_onset], get(gca, 'YLim'), 'Color', 'g');
  line([word_offset, word_offset], get(gca, 'YLim'), 'Color', 'r');
  hold off;

  % Label and title the plot
  xlabel('Time relative to word onset (ms)');
  ylabel('Voltage');
  title(sprintf('Raw Voltage for UT014, Channel 1, Event %d', event_idx));
  ```

- **Voltage for UT014 ch 1, 1 Event with Resampling**
  1. Calculate the voltage for the same event and time window as above but now resample the data to 100 Hz.
  2. Plot the resampled voltage on the same plot as the voltage calculated above to compare the two traces.
  ```matlab 
  % Calculate the voltage for the same event and time window as above, but now resample the data to 100 Hz
  resampled_voltage = resample(voltage, 100, eeg_data.srate);

  % Create a time vector for the resampled data
  resampled_time = (-1000:1000) / 100;

  % Plot the resampled voltage on the same plot as the original voltage
  hold on;
  plot(resampled_time, resampled_voltage);
  hold off;

  % Add a legend to differentiate the two traces
  legend('Original Voltage', 'Resampled Voltage');

  % Label and title the plot
  xlabel('Time relative to word onset (ms)');
  ylabel('Voltage');
  title(sprintf('Comparison of Raw Voltage for UT014, Channel 1, Event %d', event_idx));

  ```
#### 3.3.4.2 Plotting Event-related Potential (ERP)

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

```matlab 
% Plotting the ERP for UT014, Channel 1 All Encoding Events
encoding_events = events(strcmp({events.type}, 'WORD'));
num_events = numel(encoding_events);

erp_data = zeros(num_events, 2001);  % Assuming 2001 time points

for event_idx = 1:num_events
    eeg_data = load(encoding_events(event_idx).eegfile);
    voltage = getems(eeg_data.data, eeg_data.srate, encoding_events(event_idx).eegoffset, encoding_events(event_idx).eegoffset + encoding_events(event_idx).eeglength, [-1000, 1000], [58 62], 'stop');
    erp_data(event_idx, :) = voltage;
end

mean_voltage = mean(erp_data, 1);
std_voltage = std(erp_data, 0, 1);
sem_voltage = std_voltage / sqrt(num_events);

time = (-1000:1000) / eeg_data.srate;

figure;
errorbar(time, mean_voltage, sem_voltage);
xlabel('Time relative to word onset (ms)');
ylabel('Voltage');
title('ERP for UT014, Channel 1, All Encoding Events');

% Plotting the ERP for 2 Channels for All Encoding Events for UT014
erp_data_ch2 = zeros(num_events, 2001);  % Assuming 2001 time points

for event_idx = 1:num_events
    eeg_data_ch2 = load(encoding_events(event_idx).eegfile_ch2);
    voltage_ch2 = getems(eeg_data_ch2.data, eeg_data_ch2.srate, encoding_events(event_idx).eegoffset_ch2, encoding_events(event_idx).eegoffset_ch2 + encoding_events(event_idx).eeglength_ch2, [-1000, 1000], [58 62], 'stop');
    erp_data_ch2(event_idx, :) = voltage_ch2;
end

mean_voltage_ch2 = mean(erp_data_ch2, 1);
std_voltage_ch2 = std(erp_data_ch2, 0, 1);
sem_voltage_ch2 = std_voltage_ch2 / sqrt(num_events);

figure;
hold on;
errorbar(time, mean_voltage, sem_voltage);
errorbar(time, mean_voltage_ch2, sem_voltage_ch2);
hold off;

xlabel('Time relative to word onset (ms)');
ylabel('Voltage');
title('ERP for UT014, Channels 1 and 2, All Encoding Events');
legend('Channel 1', 'Channel 2');

% Plotting the Baseline Re-referenced ERP for 2 Channels
baseline_start = -150;
baseline_end = 0;

baseline_erp_data = erp_data - mean(erp_data(:, time >= baseline_start & time <= baseline_end), 2);
baseline_erp_data_ch2 = erp_data_ch2 - mean(erp_data_ch2(:, time >= baseline_start & time <= baseline_end), 2);

mean_baseline_voltage = mean(baseline_erp_data, 1);
std_baseline_voltage = std(baseline_erp_data, 0, 1);
sem_baseline_voltage = std_baseline_voltage / sqrt(num_events);

mean_baseline_voltage_ch2 = mean(baseline_erp_data_ch2, 1);
std_baseline_voltage_ch2 = std(baseline_erp_data_ch2, 0, 1);
sem_baseline_voltage_ch2 = std_baseline_voltage_ch2 / sqrt(num_events);

figure;
hold on;
errorbar(time, mean_baseline_voltage, sem_baseline_voltage);
errorbar(time, mean_baseline_voltage_ch2, sem_baseline_voltage_ch2);
hold off;

xlabel('Time relative to word onset (ms)');
ylabel('Voltage');
title('Baseline Re-referenced ERP for Channels 1 and 2');
legend('Channel 1', 'Channel 2');

% Add a horizontal line at y=0 to indicate the baseline
hold on;
plot(get(gca, 'XLim'), [0 0], 'k--');
hold off;

% Plotting the Average ERP in the Hippocampus
subject_list = dir('LegaLabTutorial/sampleData');
subject_list = subject_list([subject_list.isdir]);
subject_list = subject_list(~ismember({subject_list.name}, {'.', '..'}));

num_subjects = numel(subject_list);
all_erp_data = zeros(num_subjects, num_events, 2001);  % Assuming 2001 time points

for subject_idx = 1:num_subjects
    subject_name = subject_list(subject_idx).name;
    
    subject_events = load(fullfile('LegaLabTutorial/sampleData', subject_name, 'behavioral/FR1/events.mat'));
    encoding_events = subject_events(strcmp({subject_events.type}, 'WORD'));
    
    for event_idx = 1:num_events
        eeg_data = load(encoding_events(event_idx).eegfile);
        voltage = getems(eeg_data.data, eeg_data.srate, encoding_events(event_idx).eegoffset, encoding_events(event_idx).eegoffset + encoding_events(event_idx).eeglength, [-1000, 1000], [58 62], 'stop');
        all_erp_data(subject_idx, event_idx, :) = voltage;
    end
end

mean_hippocampal_erp = mean(all_erp_data, 1);
std_hippocampal_erp = std(all_erp_data, 0, 1);
sem_hippocampal_erp = std_hippocampal_erp / sqrt(num_subjects);

figure;
errorbar(time, squeeze(mean_hippocampal_erp), squeeze(sem_hippocampal_erp));
xlabel('Time relative to word onset (ms)');
ylabel('Voltage');
title('Average ERP in the Hippocampus');
```
