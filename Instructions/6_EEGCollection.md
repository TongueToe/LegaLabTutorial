# 5-Data_Collection
For data collection purposes, the following directories can be utilized:

- stim: This directory is dedicated to storing data related to brain stimulation.
- nonstim: This directory is dedicated to storing data related to tasks without brain stimulation.
- setup: This directory is used for storing setup-related files and documentation.

### 5.1 Verbal Tasks
Verbal tasks involve tasks that are focused on language and verbal memory. The following verbal tasks are included:

- FR1: This task is known as Free Recall 1. It involves subjects freely recalling a list of words.
- fr_stim: This task pertains to stimulation of PCC or AG.
- ARstim: This task pertains to stimulation within the AR task.
- AR1: Overview of this task is given in section 3.

### 5.2 Spatial Tasks
Spatial tasks concentrate on spatial cognition and memory. The following spatial tasks are included:

- TH1: This task is referred to as Tower of Hanoi 1. It assesses spatial problem-solving skills.
- train: This task involves spatial navigation training, designed to enhance spatial memory and navigation abilities.

### 5.3 Stim-Only Tasks
Stim-Only tasks involve tasks that primarily revolve around brain stimulation. The following stim-only tasks are included:

- CCEP: This task stands for Cortical Cerebral Evoked Potentials. It measures the brain's response to electrical stimulation.
- cortical mapping: This task involves mapping the cortical areas of the brain.
- BNstim: This task send biniary noise stimulation to PCC


It is important to maintain proper organization and labeling of data to ensure easy access and retrieval. Each task category should have its own dedicated folder within the corresponding data collection directory. Additionally, adhering to data management best practices, such as consistent file naming conventions and regular backups, is essential for efficient data analysis and preservation.


## 6. Data Processing

In order to analyze patient data, the behavioral and EEG components need to be processed and organized into the appropriate format. The data processing pipeline typically consists of several steps, including memory testing, obtaining EEG recordings, splitting the EEG recording, creating an event structure, and aligning events. In this section, we will focus on the processing details of the most common memory task analyzed in the lab: FR1.

FR1 (Free Recall 1) Task Processing:
1. Memory Testing: Conduct the Free Recall 1 task with the patient, where they freely recall a list of words.
2. Obtain EEG Recording: Record the EEG signals from the patient during the task using the appropriate equipment.
3. Split EEG Recording: Split the continuous EEG recording into segments that correspond to each trial or event in the task. This can be done using software tools or custom scripts to identify and extract the relevant time periods for each trial.
4. Make Event Structure: Create an event structure, typically in the form of a MATLAB .mat file, which contains information about the task events and their corresponding timings. This event structure should include details such as subject ID, session number, list number, serial position, event type, item presented/recalled, recall accuracy, and EEG file references.
5. Align Events: Align the events in the event structure with the corresponding EEG segments. This involves matching the timings of the events with the timestamps in the EEG recording, ensuring that the EEG data for each event is properly associated.

By following this data processing pipeline, the behavioral and EEG components of the FR1 task can be organized and prepared for further analysis. It is crucial to accurately label and align the events to ensure the synchronization between behavioral performance and EEG recordings. This will enable subsequent analyses such as event-related potential (ERP) extraction, time-frequency decomposition, and connectivity analysis.

Proper documentation and version control should be maintained throughout the data processing pipeline to ensure reproducibility and facilitate collaboration among researchers. Additionally, it is essential to adhere to data privacy and protection guidelines when handling patient data, following institutional protocols and obtaining necessary permissions and consents.

Remember to consult the specific protocols and guidelines provided by your lab or institution for detailed instructions on data processing procedures and tools.
Apologies for the oversight. Here's the missing section:

## 6.1 Memory Testing

Before conducting memory tests with the patient, it is crucial to start and stop the clinical EEG recording. This ensures that the session recording is isolated for analysis purposes. One critical aspect to keep in mind during memory testing is the presence of sync pulses on the clinical EEG. These sync pulses, injected into channel DC09 by the testing laptop, serve as markers to align the session events with the EEG time based on Unix timestamps. If no sync pulses are recorded during the testing session, the session will be deemed useless and should be discarded.

After completing the memory testing session, the audio files should be immediately annotated using PennTotalRecall by the person who administered the test. PennTotalRecall will generate .ann files for each list, which are integral for the subsequent event creation and analysis processes.

## 6.2 Obtain EEG Recording

After memory testing, it is essential to save the EEG recording for the corresponding session. The EEG recording files will vary depending on whether it is a macro or micro recording. For macro recordings, the files of interest are typically in the format .21E and .EEG, while for micro recordings, the files are usually .ns3 and .ns6.

To ensure proper organization, create a "raw" folder within the subject's directory and save the EEG recording files in this folder. The recommended naming convention for the folder is "MM DD YYYY [task name]," indicating the date and task associated with the recording.

## 6.3 Split EEG Recording

The next step in the data processing pipeline is to split the raw EEG recording into individual channel components and perform re-referencing. This process can be achieved using a wrapper script called "nk_split_wrapper.m."

Before running the script, create a new "tagnameorder_script.m" file inside the "docs" folder of the subject's directory. You can copy the template from a previous subject and update the electrode label names to match the current subject's recording. The electrode labels can be found in the .21E file (open with TextEdit), which lists the active channels during the recording. Rename the labels in the tagnameorder_script.m file accordingly, ensuring there are no repeats and excluding labels that do not start with "L" or "R" (EKG and DC should always be included last). Save the file and restart Matlab to ensure the tag name file is recognized.

To split the EEG recording, open "nk_split_wrapper.m" and modify the subject name and raw folder name to match the session's information. Then, click "run" to execute the script. The command prompt will indicate the creation of a jacksheet and noreref files for each electrode, and the script will pause in debug mode.

Check the jacksheet in the "docs" folder to ensure there are only 130 channels and that all the labels appear appropriate. If everything looks correct, type "dbcont" in the command prompt to continue the script. The command prompt will then display a list of electrodes to be included or excluded in the re-referencing step. Include all electrodes except for EKG and DC in the reference.

After completing the debugging process, the re-referenced electrode files will populate in the "reref" folder within the subject directory.

Note: It's important to be aware that the macro recordings from Parkland and Zale may have different file formats. The Zale EEG recordings are often in an extended format, allowing for more than 128 channels. In this case, you will need to use the EEG splitter, a GUI tool, to split the Zale EEG recording. Simply follow the instructions provided by the EEG splitter to complete the splitting process.

## 7 Additional Resources

For more detailed information and resources, you can refer to the [Additional Resources](DataCollection.md) file.
