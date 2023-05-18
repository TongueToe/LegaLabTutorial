# 3-EEG_database

## EEG database 

## 3.1 Behavioral-Tasks

**Free Recall (FR) Task**


**Assciocative Recognition (AR) Task** 
you can find detailed explanation of AR task here: [AR Task](../src/ar_task_explanation.pdf)

## 3.2 EEG-structure

### 3.2.1 EEG directory

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

### 3.2.1 event.mat structure 

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











In computational neuroscience, analyzing EEG data often involves studying signal characteristics across trials of different conditions. In the context of memory research, the focus is on understanding the brain signals associated with remembering or forgetting information. This analysis can be conducted during two specific time periods: the encoding period and the retrieval period.

1. **Encoding Period Analysis**: The goal of analyzing the encoding period is to identify differences in brain states that occur after the presentation of a stimulus or item. Typically, conditions in the encoding period are categorized as "Recalled" and "Non-recalled" based on the subject's later response to the item. The Recalled condition represents trials in which the subject later recalls the item, while the Non-recalled condition represents trials in which the subject does not recall the item.

2. **Retrieval Period Analysis**: Analyzing the retrieval period focuses on examining brain states before the recall of an item. Similar to the encoding period, conditions in the retrieval period are categorized as "Correctly Recalled" and "Incorrectly Recalled" (or "Intrusions"). The Correctly Recalled condition represents trials in which the subject accurately recalls the item, while the Incorrectly Recalled condition represents trials in which the subject recalls an incorrect item or makes an intrusion error.

To ensure clarity and facilitate effective communication, it is important to maintain consistent terminology when describing these conditions and their associated analysis methods. By using standardized terms, researchers can better explain and understand the specific analysis techniques employed in memory-related EEG studies.

## 3.1 Basic Signal Processing Background

In signal processing, a fundamental concept is the Fourier Theorem, which states that any continuous time-varying signal can be expressed as a sum of sinusoids with varying frequencies, amplitudes, and phase shifts (Fourier Series). While Fourier Series deals with expressing signals as a combination of sinusoids, in time-frequency decomposition, we encounter the reverse problem: we have a signal and want to break it down into its individual frequency components.

This is achieved through a linear operation called the Fourier Transform or Fast Fourier Transform (FFT). The Fourier Transform calculates multiple dot products between the signal of interest and sinusoids of different frequencies, allowing us to visualize the presence of different frequency components in the signal. By applying the FFT, the signal is transformed from the time-domain into the frequency-domain, where time information is lost since sinusoids have infinite duration.

To preserve temporal precision during the transformation, a finite kernel is used in the dot product calculations. One common approach is to use a wavelet, with the Morlet wavelet being a widely used example. The Morlet wavelet represents a sine wave modulated by a Gaussian (normal distribution) function. Wavelets, such as the Morlet wavelet, are particularly useful for localizing frequency information in time, as they provide control over the tradeoff between temporal and frequency precision.

In our lab, we predominantly use wavelets for time-frequency decomposition, as they allow us to analyze how frequency patterns change over time during the encoding and retrieval periods of a memory task. While a detailed understanding of the mathematical intricacies behind time-frequency decomposition is not necessary for performing analysis, it is beneficial to have a general understanding of these algorithms and how they process signals. This understanding helps to grasp the overall process and interpretation of the results.

For more comprehensive information on decomposition and wavelet theories, I recommend referring to Chapter 11 of Cohen's book, which delves deeper into these concepts and their applications in signal processing.

## 3.2 Organization of Data

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

## 3.3 Raw EEG and Event-Related Potentials (ERPs)

An event-related potential (ERP) refers to the change in voltage patterns observed during an "event" of interest. These events can be any stimuli presented to the subject or any responses obtained from them during a memory task. The underlying idea of an ERP is that any consistent voltage deflection observed after averaging across multiple events reflects a time-locked response to the evaluated event.

For example, if a positive voltage deflection consistently occurs every time a subject studies a word, averaging the voltage across all encoding events will reveal a positive voltage deflection. However, if there are positive deflections for some words and negative deflections for others, the averaged voltages will be roughly around zero. Similarly, if there are early positive deflections for some words and late deflections for others, the average voltage (ERP) may show a broad positive deflection with a small magnitude or no discernible voltage deflection at all. ERPs primarily show strong effects for voltage changes with consistent directionality and timing across multiple trials.

It is important to note that the voltage deflections observed in an ERP do not necessarily reflect a true voltage deflection occurring in every encoding event. For instance, if a few trials exhibit very large positive voltage deflections while the majority of trials show small negative voltage deflections, the average may appear to show a positive deflection (although not as large as those few trials with true positive deflections).

ERPs are extracted from raw EEG signals as time-specific segments. In our lab, we utilize a custom Matlab function called `gete_ms` for this purpose. This function is a core component of the EEG toolbox and enables the extraction of voltages recorded from a specific electrode. It utilizes the `eegfile` path in the `event.mat` structure to locate the corresponding EEG file and the `eegoffset` field in the `events.mat` file to determine the time relative to the beginning of the recording for analysis.

The inputs and outputs of the `gete_ms` function are as follows:

**Inputs:**
- `channel`: The channel number you wish to analyze.
- `events`: The events for which you want the voltages. The output will provide a voltage for each time point for each event.
- `DurationMS`: The duration (in milliseconds) of the EEG recording you want to analyze.
- `OffsetMS`: The time (in milliseconds) relative to the beginning of the event at which you want to start analyzing the EEG data.
- `BufferMS`: The time (in milliseconds) before and after the desired time window to use as a buffer to prevent edge artifacts. A value of 500 ms can be used for this.
- `filtfreq`: The frequencies you want to filter out or allow through. For example, [58 62] can be used to filter out 60 Hz line noise from electrical outlets in the U.S.
- `filttype`: The type of filter you want to use. "stop" does not allow the specified frequencies through and is typically used for line-noise filtering. "low" allows frequencies below `filtfreq` through (low-pass filtering), while "high" allows frequencies above the specified frequency through (high-pass filtering).
- `filtorder`: The significance of this input is beyond the scope of this tutorial. A value of 1 can be used for this field.
- `resampleFreq`: This input can be used to change the sampling rate of the EEG file. It is useful when comparing EEG recordings with different sampling rates. For example, if subjects from different institutions have different recording rates, resampling the data to a common rate can facilitate comparison.
- `RelativeMS`: This input allows you to subtract a baseline period from the voltage. It helps mitigate the effects of voltage drift across a session and enables a more standardized comparison of activity across electrodes and subjects.

**Outputs:**
- `EEG`: A matrix of voltage values with dimensions (# of events by # of time points).
- `resampleFreq`: The output of the sampling rate used.

Here is an example of using the `gete_ms` function:
```matlab
EEG = gete_ms(21, events, 1800, -200, 500, [58 62], 'stop', 1, 200, [-200 0]);
```
This example will return a matrix with a number of rows equal to the number of events in `events` and 360 columns. The resample frequency is 200 Hz, so each sample represents 5 ms. The duration of the computed voltage is 1800 ms (360 samples). The voltage output starts 200 ms before the word onset and ends 1600 ms after the word onset. Therefore, samples 1 to 40 correspond to the period before the word, and samples 41 to 360 represent the period after the word. A baseline subtraction of the average voltage from -200 ms to 0 ms was performed.

By utilizing the `gete_ms` function, researchers can extract ERPs from the raw EEG signals and examine the voltage changes over time in response to specific events of interest.

