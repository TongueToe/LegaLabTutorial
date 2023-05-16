# LegaLabTutorial
Lega Lab Tutorial
# Lab-Introduction

Welcome to the lab! This tutorial aims to provide you with an overview of the lab's activities and help you become a productive and contributing member. We will cover various topics, including setting up BioHPC, running analysis, patient testing, and more.

## Lab Overview

Our lab primarily focuses on programming, with a strong emphasis on Matlab. Prior experience with Matlab is a plus but not mandatory. Many lab members have successfully gone through the program without prior coding experience, so don't worry if you're new to it. You are expected to learn quickly, and the best way to do that is by diving into programming.

To help you get started, we have provided several template analysis and plotting scripts on BioHPC. These scripts will guide you through the basics. Remember, learning programming doesn't come from running code that works; it comes from fixing code that doesn't work. Initially, you might encounter challenges, and that's perfectly fine. You'll never improve if you don't struggle through debugging your own code.

Fortunately, Matlab is extremely user-friendly and offers abundant online and offline documentation. The `help` function is a powerful tool when you encounter unfamiliar functions (e.g., type in `help reshape` to see documentation on the `reshape` function). In most cases, you can even type your questions directly into a search engine like Google (e.g., "How to average values in MATLAB?", "How to loop through files in a folder using MATLAB?", or "How to plot a line in MATLAB?"). Spend a reasonable amount of time troubleshooting an error before seeking assistance, and any lab member will be happy to help.

For experienced Matlab users, the provided templates serve as a guide. As you become more familiar with the analysis, you can write your own scripts to process the code in a way that suits your needs.

## Feedback and Updates

If you come across any issues with this tutorial (e.g., unclear instructions, typos), please send an email to jui-jui.lin@gmail.com. This tutorial will be continuously updated to provide a comprehensive guide for new lab members, helping them develop the necessary skills for complex neural signal analyses. Remember, if you have a question, it's likely that someone in the future will have the same question too. By addressing as many questions as possible within this guide, we can create a valuable resource for everyone.

Thank you and enjoy your time in the lab!

## BioHPC

BioHPC is the high-performance computing group at UT Southwestern. They offer a range of computational resources, workshops, and cloud storage options specifically designed for research labs on campus. This section provides a brief overview of getting started with BioHPC, but it does not cover every resource they offer in detail.

To access comprehensive documentation and PowerPoint slides on using BioHPC's resources, visit their website: [BioHPC Portal](https://portal.biohpc.swmed.edu). These resources will provide you with step-by-step instructions and in-depth explanations of various tools and services.

If you have any specific questions or need assistance, you can reach out to BioHPC's support team by sending an email to biohpc-help@utsouthwestern.edu. They will be happy to help you with any issues or inquiries related to BioHPC.

BioHPC's cloud storage options, computational resources, and workshops are invaluable assets for conducting research. Make sure to explore their offerings and utilize them effectively to enhance your work in the lab.

## 2.1 Getting Access

To obtain access to BioHPC, you need to follow these steps:

1. Register for an account on the BioHPC website.
2. Attend the orientation workshop, which takes place on the first Wednesday of every month.
3. To sign up for the session, send an email to the support team. They will provide you with further details and confirm your attendance.

After attending the orientation workshop, your account will be activated, granting you access to BioHPC's resources.

## 2.2 Directory Organization

Once your account is activated, you will have access to three directories: `/home2`, `/work`, and `/project`. Here's a breakdown of their purposes:

- `/home2`: This directory serves as your home directory, and your personal folder will be located at `/home2/[your UT Southwestern ID]`. It is recommended to use this directory primarily for backing up your code, as it has a storage limit of 50 GB.

- `/work`: Your work directory is where you should conduct your analysis and save the results such as plots, matrices, and other output files. This directory offers a more substantial storage capacity of 5 TB, making it suitable for storing and working with larger datasets.

When performing your analysis and saving outputs, make sure to utilize your `/work` directory to ensure you don't exceed the storage limits.

Properly organizing and utilizing these directories will help you manage your work efficiently and ensure you have sufficient storage space for your research activities on BioHPC.

## Project Directory (/project)

In the BioHPC environment, the project directory (`/project`) is where data for every lab is stored. As a member of our lab, you will have access to our specific lab's data, located at `/project/TIBIR/Lega lab/shared/lega ansir/`.

Within the project directory, there are several folders, but the two key folders you should be familiar with are:

1. **shared code**: This folder contains essential resources for our lab's analyses. It includes a master EEG toolbox that covers various analysis tasks, data processing functions (such as event-making), and lab tutorials for different tasks.

2. **subjFiles**: This folder houses all the subject-specific data for our lab. The individual folders within `subjFiles` are organized as follows:

   - **behavioral**: This folder contains behavioral data for all the tasks performed by the patients. The data is organized as event structures.

   - **docs**: Here, you'll find miscellaneous text files with electrode labels, including jacksheets, depth electrode information, and other relevant documentation.

   - **eeg.noreref**: This folder stores the raw EEG files for all recorded channels during the testing sessions.

   - **eeg.reref**: Similar to the `eeg.noreref` folder, this folder also contains raw EEG files. However, the values in this folder are recalculated using an average rereferencing scheme. These files are typically used for aligning event structures.

   - **freesurfer**: This folder contains CT and MRI files obtained from the FreeSurfer software.

   - **raw**: Here, you will find the original EEG files directly from the clinical recording systems. These files have extensions like `.EEG`, `.21E`, or `.ns2`.

   - **tal**: The `tal` folder contains information on the localization of electrodes. It includes a structure that provides Talairach coordinates for individual electrode contacts.

By familiarizing yourself with these specific folders within the `subjFiles` directory, you'll be able to access and work with the relevant data and resources needed for your analyses in our lab.

Remember to adhere to any data handling and access protocols established within the lab to ensure the security and integrity of the data.


## 2.3 Working on the Cloud

There are multiple ways to access and work with data from the lab directory on the BioHPC cloud. The most efficient method is to use the Web Visualization feature provided by BioHPC. This allows you to remotely control a node on the cluster, essentially providing you with a cloud-based computer environment. Follow these steps to set it up:

1. Download TurboVNC from the official website: [TurboVNC](https://www.turbovnc.org). TurboVNC sets up the graphical user interface (GUI) for the Web Visualization.

2. Start the Web Visualization from the BioHPC website. It will provide you with a node address and a password.

3. Launch TurboVNC and enter the node address and password when prompted. If everything is set up correctly, a Linux desktop will appear (Figure 1). The GUI will function like a regular computer, with various software preinstalled, including Matlab, Python, R, and more.

4. To start a program, open a terminal window by going to "Applications" -> "System Tools" at the top left-hand corner of the screen.

5. For example, to start an instance of Matlab, check the available Matlab versions by typing `module avail matlab` in the terminal. Choose your preferred version (avoid version 2017 due to a bug explained later), and load it with the command `module load matlab/[version]`. Finally, start Matlab by typing `matlab`.

6. You can start other modules in a similar way by loading them correctly. To see the complete list of available modules, type `module avail` in the terminal.

Another method to access data on BioHPC is by mounting the cloud directories to your local device. Follow these steps for macOS:

1. Open any Finder window and click on "Go" -> "Connect to Server" in the toolbar at the top of your screen.

2. Enter the following server addresses based on the directory you want to access:
   - `/home2`: `smb://lamella.biohpc.swmed.edu/<username>`
   - `/project`: `smb://lamella.biohpc.swmed.edu/project`
   - `/work`: `smb://lamella.biohpc.swmed.edu/work`

3. You will be prompted to enter your BioHPC account information to log in.

This method is particularly useful when transferring small files to and from the server, accessing analysis outputs, and performing offline plotting. However, it is not recommended to perform extensive troubleshooting or plotting directly on the cloud, especially when dealing with a large number of output files. Navigation and plotting with Matlab on BioHPC may be slower and can lead to formatting issues that are not experienced offline.

By using either the Web Visualization or mounting the cloud directories, you can efficiently access and work with the lab data on BioHPC, depending on your specific needs and tasks.

Regarding the lack of proper graphics drivers for the Web Visualization on Windows machines, please refer to the BioHPC introductions page for detailed instructions: [BioHPC Introduction Page](https://portal.biohpc.swmed.edu/content/guides/introduction-biohpc/).

For setting up Matlab on the cloud, follow these steps to ensure that your user preferences and paths are properly configured:

1. Open Matlab on the cloud.

2. By default, Matlab recognizes your `/home2` directory as the initial folder. However, it is more efficient to work from and save your outputs to your `/work` directory. To modify this setting, click on the "Home" tab and go to "Preferences".

3. In the left-hand side menu, select "General". Under "Initial working folder", choose the "Custom" option. Then, navigate to your `/work` folder by clicking the "..." button on the right. Apply the changes by clicking "Apply" and "OK" to confirm.

   Note: If you are using a 2017 version of Matlab, this setting may be bugged, so it is recommended to choose an earlier version where you can modify the initial working path.

4. Next, you need to set up the paths for Matlab to recognize the locations of your functions, scripts, and toolboxes. Create a new script from the "Home" tab and name it `startup.m`. Save it to your initial working directory (`/work`).

5. Inside the `startup.m` script, add the following two lines of code:
   ```matlab
   addpath(genpath('/work/TIBIR/Lega lab/[your ID]'));
   addpath(genpath('/project/TIBIR/Lega lab/shared/lega ansir/shared code'));
   ```

   This script will run every time Matlab starts up and automatically load code from your `/work` directory and the lab's master EEG toolbox without requiring manual intervention.

6. Restart Matlab and the terminal to confirm the change in the initial working directory displayed in the current folder.

7. To check if your code has been properly added, you can use the `which` function. For example, to check if `gete ms.m` has been added, type `which gete ms.m` in the Matlab terminal. If the output returns a directory, it means the startup script is working correctly.

Please note that these setup steps only apply to the Matlab version you are currently using. If you go through these steps for one version (e.g., 2016b), the changes will not be reflected when you try to start another version. It is recommended to pick one version and stick with it to maintain consistent settings and configurations. For the purpose of executing any tutorial code, you should copy the shared code folder to your local directory, add it to your local Matlab’s path, and have the lab project directory mounted.

## 2.4 Running Parallel Jobs

BioHPC offers the capability to perform computations in parallel, allowing for faster processing of tasks. To utilize parallel computing, follow these guidelines and use the provided code and scripts in the `/shared code/tutorial/parallel jobs` directory:

1. All the necessary code and scripts for running parallel jobs can be found in the `/shared code/tutorial/parallel jobs` directory.

2. To organize your script for parallel processing, follow these guidelines:
   - Structure your script around a main for loop that you want to process in parallel.
   - Embed the main body of the code inside a try/catch statement. This ensures that each iteration of the loop is independent, and any errors that occur in one iteration do not interfere with others.
   - Organize the inputs into a Matlab structure (e.g., subject, electrode, regions) for sequential processing within the main for loop.
   - For each iteration of the loop, generate a "lock" file if the iteration is attempted or performed, a "done" file if completed without error, or an "error" file if an error occurs. These empty text files provide insights into the progress and results of each iteration based on their names.

   Refer to `lockfile template.m` in the tutorial folder for more detailed information on setting up your script in this format.

3. To submit a job to the cloud, you need to use two shell scripts: `srunScript.sh` and `matlabWrapper.sh`. Copy both of these files into your `/work` folder to use them for your own jobs.

4. Modify the necessary parts of these scripts to fit your specific use case. The templates are labeled to indicate the sections that need modification. Make the required changes to adapt the scripts for your job.

5. Once you have made the necessary modifications, use the Nucleus Web Terminal on the BioHPC homepage to submit the job. Type the following command:
   ```
   sbatch /work/[location of your srunScript.sh]
   ```

   This command submits the job with the specified parameters and calls the `matlabWrapper.sh` script to start the job.

Please refer to the job submission tutorial on the BioHPC homepage for more detailed information on the job submission process and additional parameters you can configure.

By following these steps and utilizing the provided code and scripts, you can harness the power of parallel computing on BioHPC to improve the efficiency of your computations.

## 2.5 Access from Off Campus

If you need to access BioHPC from off campus, you can do so by following these steps:

1. Download and install Pulse Secure, which is a virtual private network (VPN) client used to connect to the campus network. You can find the download link and detailed instructions on the intranet page: [Pulse Secure Download](http://www.utsouthwestern.net/intranet/administration/information-resources/network/vpn/).

2. Once you have installed Pulse Secure, start the program.

3. Add a connection to the server by entering the server name as "utswra.swmed.edu".

4. Enter your UTSW (UT Southwestern) password when prompted.

5. Pulse Secure will then prompt you for a secondary password, which you can obtain through the Duo Mobile app. Follow the instructions provided to authenticate your login.

6. Once the program confirms a successful connection to the campus network, you can access BioHPC as you would normally, just as if you were on campus.

By using Pulse Secure and establishing a VPN connection to the campus network, you can securely access BioHPC from off-campus locations and continue your work remotely.


## 3. Analysis of EEG Data

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

## 3.4 Oscillatory Power

## 3.4.1 Instantaneous Power using Hilbert Transform with `gete_ms`

In addition to calculating oscillatory power using the Wavelet Transform, another approach to estimate the instantaneous power of EEG signals is by utilizing the Hilbert Transform. The Hilbert Transform provides a means to extract the analytic signal, which consists of the instantaneous amplitude and phase of a time-varying signal.

To compute the instantaneous power of EEG signals using the Hilbert Transform with `gete_ms`, you can follow these steps:

1. Use the `gete_ms` function to extract the voltage values for the desired channel and events. For example:
   ```matlab
   EEG = gete_ms(21, events, 1800, -200, 500, [58 62], 'stop', 1, 200, [-200 0]);
   ```

2. Apply the Hilbert Transform to the extracted voltage signal to obtain the analytic signal. This can be done using the `hilbert` function in MATLAB:
   ```matlab
   analytic_signal = hilbert(EEG);
   ```

3. Compute the instantaneous power as the squared magnitude of the analytic signal:
   ```matlab
   instantaneous_power = abs(analytic_signal).^2;
   ```

The resulting `instantaneous_power` will provide the time-varying power estimates for each event trial in the EEG data.

Please note that this approach assumes a single-channel analysis. If you have multiple channels, you can apply the same steps to each channel separately or consider multichannel methods such as computing the average power across channels.

By employing the Hilbert Transform with `gete_ms`, you can estimate the instantaneous power of EEG signals, allowing for further analysis of the temporal dynamics and power fluctuations in the neural activity.

## 3.4.2 Time-Frequency Representation (Instantaneous Power by Frequencies) with `getphasepow`

As mentioned in the signal processing background section, time-frequency decomposition allows us to examine changes in various frequency components of a signal over time. This type of analysis is fundamental and can be performed using a critical function in the EEG toolbox called `getphasepow`. As the name suggests, this function calculates the phase and power values of a signal across all event trials in a time-frequency space using the Wavelet Transform.

Here's an example of using the `getphasepow` function:
```matlab
[phase, power] = getphasepow(21, events, 1800, 0, 500, 'filtfreq', [58 62], 'resampledrate', 500, 'freqs', freqs);
```

You may notice that the inputs for `getphasepow` are similar to those used in `gete_ms`. This is because `gete_ms` is called within `getphasepow` to extract the EEG snippets required for calculating the phase and power values for the specified channel. However, `getphasepow` also accepts an additional input called `freqs`, which is a vector of the frequencies of interest for identifying the phase and power values. This vector is typically generated using the Matlab expression `(2^(1/8)).^(8:n)`.

The resulting `phase` and `power` matrices provide information about the phase and power values at different frequencies and time points for the specified channel and events. The frequencies of interest are logarithmically spaced to provide more resolution in the lower frequency bands, as lower frequency ranges have smaller value ranges compared to higher frequency bands.

As you delve into more literature in the field, particularly studies involving rodents, you will encounter theories and findings based on changes in oscillatory power. Understanding the trends and implications of increased or decreased activities in different frequency bands in different brain regions during various memory paradigms will help you develop a better understanding of the expected results in your own analysis.

## 3.5 Connectivity Analysis
When performing connectivity analysis on EEG data, several measures can be utilized, including Phase-Locking Value (PLV), Cross-Phase Amplitude Coupling (xPAC), Phase-Amplitude Coupling (PAC), Coherence, and Correlation. Let's explore each of these measures briefly:

1. **Phase-Locking Value (PLV)**: PLV measures the phase synchronization between two EEG signals. It quantifies the consistency of phase relationships between different frequency components across trials or channels. PLV values range from 0 to 1, with higher values indicating stronger phase synchronization.

2. **Cross-Phase Amplitude Coupling (xPAC)**: xPAC examines the relationship between the phase of one frequency band and the amplitude of another frequency band. It measures how the amplitude of a higher-frequency signal is modulated by the phase of a lower-frequency signal. xPAC is particularly useful for investigating interactions between different frequency ranges.

3. **Phase-Amplitude Coupling (PAC)**: PAC assesses the coupling between the phase of one frequency band and the amplitude of the same or another frequency band. It captures how the amplitude of a signal at a specific frequency is modulated by the phase of another signal at a different frequency. PAC is commonly employed in studying functional interactions between oscillatory components.

4. **Coherence**: Coherence measures the linear relationship between two EEG signals across different frequencies. It quantifies the degree of synchronization or similarity in the phase and magnitude between two signals. Coherence values range from 0 to 1, with higher values indicating stronger linear relationships.

5. **Correlation**: Correlation is a widely used measure to assess the statistical relationship between two EEG signals. It quantifies the linear dependence between signals and ranges from -1 to +1. Positive values indicate a positive linear relationship, negative values indicate a negative linear relationship, and a value of zero indicates no linear relationship.

These measures provide different insights into connectivity patterns in EEG data. The choice of which measure to use depends on the research question, the specific hypotheses being tested, and the characteristics of the data. It is common to employ a combination of these measures to gain a more comprehensive understanding of the connectivity patterns in the brain.

Please note that these descriptions provide a brief overview, and the specific implementation and interpretation of these measures can vary depending on the research context.


**3.6 Statistical Testing**

Statistical testing plays a crucial role in research analysis by allowing us to make inferences about populations based on sample data. It helps determine the significance of observed differences or relationships and provides a framework for drawing conclusions from the data. In this section, we will discuss some common statistical tests used in this lab and provide additional resources for further understanding.

1. **T-test**: The t-test is used to compare means between two groups. It assesses whether the difference in means is statistically significant or likely to have occurred by chance. The t-test is applicable when the data follows a normal distribution and assumptions are met. Here is a resource that explains the t-test: [T-test YouTube Video](https://www.youtube.com/watch?v=0Pd3dc1GcHc&t=141s). The t-test is used to compare means between two groups. It assesses whether the difference in means is statistically significant or likely to have occurred by chance.

```matlab
% Perform independent samples t-test
group1 = [4, 5, 6, 7, 8];
group2 = [1, 2, 3, 4, 5];
[h, p, ci, stats] = ttest2(group1, group2);

% Display t-test results
disp(stats);
disp(['p-value: ' num2str(p)]);
```

2. **Wilcoxon Rank-Sum Test**: The Wilcoxon rank-sum test, also known as the Mann-Whitney U test, is a nonparametric test used to compare two independent groups when the assumptions for the t-test are not met. It evaluates whether there is a significant difference in the distribution of ranks between the groups. Here is a resource on the Wilcoxon rank-sum test: [Wilcoxon Rank-Sum Test YouTube Video](https://www.youtube.com/watch?v=nRAAAp1Bgnw&t=72s). The Wilcoxon rank-sum test, also known as the Mann-Whitney U test, is a nonparametric test used to compare two independent groups when the assumptions for the t-test are not met.

```matlab
% Perform Wilcoxon rank-sum test
group1 = [4, 5, 6, 7, 8];
group2 = [1, 2, 3, 4, 5];
[p, h, stats] = ranksum(group1, group2);

% Display rank-sum test results
disp(stats);
disp(['p-value: ' num2str(p)]);
```

3. **Analysis of Variance (ANOVA)**: ANOVA is a statistical test used to compare means across multiple groups or conditions. It determines whether there are significant differences between the means and provides information on which specific groups differ from each other. ANOVA assumes that the data follows a normal distribution and that variances are homogeneous. Here is a resource on ANOVA: [ANOVA YouTube Video](https://www.youtube.com/watch?v=-yQbZJnFXw&t=4s). NOVA is a statistical test used to compare means across multiple groups or conditions. It determines whether there are significant differences between the means.

```matlab
% Perform one-way ANOVA
group1 = [4, 5, 6, 7, 8];
group2 = [1, 2, 3, 4, 5];
group3 = [3, 4, 5, 6, 7];
[p, tbl, stats] = anova1([group1, group2, group3], [], 'off');

% Display ANOVA results
disp(tbl);
disp(['p-value: ' num2str(p)]);
```

4. **Linear Mixed Effects Model**: In addition to the previously mentioned statistical tests, another powerful tool for analyzing data with complex structures is the Mixed Effects Model. Mixed Effects Models, also known as Multilevel Models or Hierarchical Models, allow for the analysis of data with nested or clustered structures, such as repeated measures or data collected from different subjects.

In MATLAB, the Statistics and Machine Learning Toolbox provides functions for fitting mixed effects models. The `fitlme` function is commonly used for fitting linear mixed effects models. Here's an example of how to use `fitlme`:

```matlab
% Create a dataset with variables: response, predictor1, predictor2, group
dataset = readtable('data.csv');

% Fit a linear mixed effects model
model = fitlme(dataset, 'response ~ predictor1 + predictor2 + (1 | group)');

% Print the model summary
disp(model);

% Perform hypothesis tests on fixed effects
[h, p, stats] = fixedEffectsTest(model);

% Print the hypothesis test results
disp(stats);

% Extract the random effects
ranef = randomEffects(model);
disp(ranef);
```
In this example, the dataset is read from a CSV file containing columns for the response variable, predictor variables, and a grouping variable. The linear mixed effects model is specified using the formula syntax `'response ~ predictor1 + predictor2 + (1 | group)'`, where `(1 | group)` indicates that a random intercept is included for the grouping variable.

The model summary provides information about the fixed effects coefficients, random effects variance components, and goodness-of-fit statistics. Hypothesis tests on the fixed effects can be performed using the `fixedEffectsTest` function, which returns hypothesis test results for each fixed effect.

The `randomEffects` function extracts the estimated random effects from the fitted model.

For more advanced modeling options, such as including random slopes or using different covariance structures, MATLAB offers additional functions like `fitlmematrix`, `fitglme`, and `fitrm`.


Remember to adjust the syntax and options of the functions according to your data and analysis requirements. MATLAB provides additional options and advanced features for these statistical tests, which you can explore in the MATLAB documentation for each function.

Further resources:
- MATLAB documentation on ttest2: [ttest2](https://www.mathworks.com/help/stats/ttest2.html)
- MATLAB documentation on ranksum: [ranksum](https://www.mathworks.com/help/stats/ranksum.html)
- MATLAB documentation on anova1: [anova1](https://www.mathworks.com/help/stats/anova1.html)
- MATLAB documentation on Mixed Effects Models: [Mixed Effects Models in MATLAB](https://www.mathworks.com/help/stats/mixed-effects-models.html)
- LME4-R Package: [Linear Mixed-Effects Models using R](https://cran.r-project.org/web/packages/lme4/vignettes/lmer.pdf)


These resources offer more detailed information and examples on conducting these statistical tests using MATLAB.


It is important to understand the correct interpretation of p-values in statistical comparisons. A p-value represents the probability of observing differences as extreme or more extreme between the compared groups, assuming the null hypothesis is true. It does not provide information about the size or practical significance of the observed differences. It is crucial to interpret p-values in conjunction with effect sizes and consider the context of the research question.

Here are some additional resources for statistical analysis:
- [GraphPad Prism Guide](https://www.graphpad.com/guides/prism/7/statistics/)
- [Statistics Fun YouTube Channel](https://www.youtube.com/user/statisticsfun)
- Cohen, J. (1992). *A power primer*. Psychological Bulletin, 112(1), 155-159. (Cohen's textbook on effect sizes)



## 4 Exploring Folders on your Apple Computer Using Terminal
It is often much more efficient to work with folders and files on your computer from the command line (Terminal on an Apple Computer). Depending on your operating system, the command line interface on your computer may be different but the functionality should be preserved across all systems.
Terminal is effectively the same as ’Finder’ on an Apple Computer or ’My Computer’ on a PC but using it requires becoming acquainted with some common commands. While it may seem to add unnecessary complexity at first, you will soon find that navigating through your computer from the command line can help you accomplish seemingly tedious tasks much more efficiently.
As you first begin working in Terminal, it may be helpful to have a file browser window (such as Finder on a Mac) open. As you use terminal commands to navigate from your computer, verify that the result of navigating through your computer with the file browser is the same as navigating through the command line.

## 4.1 Navigating and Managing Files and Folders in Terminal

Here are some common command line functions for navigating and managing files and folders in Terminal:

- `pwd`: Prints the current directory (path).
- `ls`: Lists the contents of the current directory.
- `ls -l`: Lists detailed information about the files and folders in the current directory, including permissions, owner, size, and creation date.
- `cd [path]`: Changes the current directory to the specified path.
- `cd ..`: Moves up to the parent directory.
- `cd ~`: Moves to the user's home directory.
- `cp [source] [destination]`: Copies a file or folder from the source path to the destination path.
- `cp -r [source] [destination]`: Copies a folder and its contents recursively.
- `mv [source] [destination]`: Moves or renames a file or folder.
- `mkdir [path]`: Creates a new folder at the specified path.
- `rm [path]`: Removes (deletes) a file or empty folder at the specified path.
- `rm -r [path]`: Removes a folder and its contents recursively.
- `ssh [user]@[server]`: Connects to a remote server using Secure Shell (SSH) protocol.
- `scp [source] [destination]`: Copies files or folders between local and remote machines using SSH.
- `chmod [permissions] [file]`: Changes the permissions of a file or folder.
- `chown [owner]:[group] [file]`: Changes the owner and group of a file or folder.
- `sudo [command]`: Executes a command with superuser (root) privileges.

These commands are just a subset of the many available commands in Terminal. It's important to exercise caution when using commands like `rm` and `sudo`, as they can have permanent and potentially destructive effects. Always double-check your commands and ensure that you have appropriate permissions before executing them.


### Data Collection
For data collection purposes, the following directories can be utilized:

- stim: This directory is dedicated to storing data related to brain stimulation.
- nonstim: This directory is dedicated to storing data related to tasks without brain stimulation.
- setup: This directory is used for storing setup-related files and documentation.

### 5.1 Verbal Tasks
Verbal tasks involve tasks that are focused on language and verbal memory. The following verbal tasks are included:

- FR1: This task is known as Free Recall 1. It involves subjects freely recalling a list of words.
- fr_stim: This task pertains to stimulation of PCC or AG.
- ARstim: 
- AR1:

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
