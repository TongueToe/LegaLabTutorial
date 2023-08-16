# 4-Analyses_of_EEG_Data

# Table of Contents

- [4. Analyses of EEG Data](#4-analyses-of-eeg-data)
   - [4.1 Raw EEG and Event-Related Potentials (ERPs)](#41-raw-eeg-and-event-related-potentials-erps)
   - [4.2 Basic Signal Processing](#42-basic-signal-processing)
   - [4.3 EEG Pre-processing](#43-eeg-pre-processing)
   - [4.4 Power Spectrum](#44-power-spectrum)
   - [4.5 Analyzing Frequency Bands](#45-analyzing-frequency-bands)
   - [4.6 Oscillatory Power and Phase](#46-oscillatory-power-and-phase)
      - [4.6.1 Instantaneous Power and phase using Hilbert Transform with band-pass filtered EEG signals via gete_ms](#461-instantaneous-power-and-phase-using-hilbert-transform-with-band-pass-filtered-eeg-signals-via-gete_ms)
      - [4.6.2 Time-Frequency Representation (Instantaneous Power and Phase by Frequencies) with getphasepow](#462-time-frequency-representation-instantaneous-power-and-phase-by-frequencies-with-getphasepow)
   - [4.7 Connectivity Analysis](#47-connectivity-analysis)
      - [4.7.1 Phase-Locking Value (PLV)](#471-phase-locking-value-plv)
      - [4.7.2 Cross-Phase Amplitude Coupling (xPAC)](#472-cross-phase-amplitude-coupling-xpac)
      - [4.7.3 Phase-Amplitude Coupling (PAC)](#473-phase-amplitude-coupling-pac)
      - [4.7.4 Coherence](#474-coherence)
      - [4.7.5 Correlation](#475-correlation)
   - [4.8 Statistical Testing](#48-statistical-testing)
      - [4.8.1 T-test](#481-t-test)
      - [4.8.2 Wilcoxon Rank-Sum Test](#482-wilcoxon-rank-sum-test)
      - [4.8.3 Analysis of Variance (ANOVA)](#483-analysis-of-variance-anova)
      - [4.8.4 Linear Mixed Effects Model](#484-linear-mixed-effects-model)

## 4.1 Raw EEG and Event-Related Potentials (ERPs)

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

../src/eeg_toolbox


```matlab
% Add the eeg_toolbox to the MATLAB search path
addpath(genpath('../../src/eeg_toolbox'));

% Load the EEG data from the events.mat file
EEGdata = ('../../behData/UT014/behavioral/FR1/session_0/events.mat');
load(EEGdata);

% Filter the encoding events based on recall status
encodingevents = events(strcmp({events.type}, 'WORD'));
recalled = encodingevents([encodingevents.recalled] == 1);
nonrecalled = encodingevents([encodingevents.recalled] == 0);

% Specify the electrode number of interest
electrode_num = 77;

% Set the sampling frequency (Fs) and time vector (tval)
Fs = 500;
tval = linspace(0, 1800, 1.8 * Fs);

% Get the raw EEG trials for the specified electrode and time window
EEG = gete_ms(electrode_num, recalled, 1800, -0, 200);

% Resample the EEG data to the desired sampling frequency
EEG = resample(EEG', Fs, 1000)';

% Plot the raw EEG trials
figure('position',[20 20 600 900])
plot(tval, EEG')
xlabel('Time (ms)')
ylabel('Amplitude (uV)')
title('Raw EEG Trials')

```

## 4.2 Basic Signal Processing

In signal processing, a fundamental concept is the Fourier Theorem, which states that any continuous time-varying signal can be expressed as a sum of sinusoids with varying frequencies, amplitudes, and phase shifts (Fourier Series). While Fourier Series deals with expressing signals as a combination of sinusoids, in time-frequency decomposition, we encounter the reverse problem: we have a signal and want to break it down into its individual frequency components.

This is achieved through a linear operation called the Fourier Transform or Fast Fourier Transform (FFT). The Fourier Transform calculates multiple dot products between the signal of interest and sinusoids of different frequencies, allowing us to visualize the presence of different frequency components in the signal. By applying the FFT, the signal is transformed from the time-domain into the frequency-domain, where time information is lost since sinusoids have infinite duration.

To preserve temporal precision during the transformation, a finite kernel is used in the dot product calculations. One common approach is to use a wavelet, with the Morlet wavelet being a widely used example. The Morlet wavelet represents a sine wave modulated by a Gaussian (normal distribution) function. Wavelets, such as the Morlet wavelet, are particularly useful for localizing frequency information in time, as they provide control over the tradeoff between temporal and frequency precision.

In our lab, we predominantly use wavelets for time-frequency decomposition, as they allow us to analyze how frequency patterns change over time during the encoding and retrieval periods of a memory task. While a detailed understanding of the mathematical intricacies behind time-frequency decomposition is not necessary for performing analysis, it is beneficial to have a general understanding of these algorithms and how they process signals. This understanding helps to grasp the overall process and interpretation of the results.

For more comprehensive information on decomposition and wavelet theories, I recommend referring to Chapter 11 of Cohen's book, which delves deeper into these concepts and their applications in signal processing.

**IMPORTANT: Most Matlab built-in functions such as hilbter() and bandpass() works on columns instead of rows, and we mostly use rows as EEG trials. Be cautious when applying these funcitons and make sure you use transpose ' (as shown in following exmaples)**

## 4.3 EEG Pre-processing

- [Line Noise Removal](/Instructions/4_EEGAnalyses.md#line-noise-removal)
      Line noise can often corrupt EEG signals, introducing unwanted frequency components that can interfere with the analysis. In order to address this issue, we employ techniques for line noise removal. These techniques involve filtering the EEG data to attenuate or eliminate the specific frequencies associated with line noise, typically 60 Hz, depending on the power grid frequency in your region. By removing line noise, we can enhance the quality of the EEG signals and reduce potential distortions in the data.
- [Outlier Removal](/Instructions/4_EEGAnalyses.md#outlier-removal)
      Outliers in EEG data can arise due to various factors, such as artifacts, electrode disconnections, or physiological anomalies. These outliers can significantly affect the accuracy and reliability of subsequent analyses. To ensure robust and accurate data analysis, we implement outlier removal methods. These methods aim to identify and exclude data points that deviate significantly from the overall pattern of the EEG signals. By removing outliers, we can mitigate their impact on the analysis results and obtain more reliable findings.
- [Denoise (Optional)](/Instructions/4_EEGAnalyses.md#denoise-optional)
      In some cases, additional denoising techniques may be applied to further improve the quality of the EEG data. Denoising methods can help reduce unwanted noise, artifacts, or interference that might be present in the signals. These techniques employ various algorithms and signal processing approaches to enhance the signal-to-noise ratio and extract more meaningful information from the EEG data. The choice to utilize denoising techniques depends on the specific research goals and the nature of the data being analyzed. While denoising can be beneficial, it is important to carefully evaluate its potential effects on the data and interpret the results accordingly.

**References:** [^1]: Wang, D.X., & Davila, C.E. (2019). Subspace averaging of auditory evoked potentials. *2019 41st Annual International Conference of the IEEE Engineering in Medicine and Biology Society (EMBC)*. IEEE. [Link to Paper](https://ieeexplore.ieee.org/abstract/document/8857818)

**Example Codes:**
```matlab
% Remove DC offsets and line noise
EEG_denoised = bandstop(EEG', [59, 61], Fs, 'Steepness', 0.85)'; % remove line-noise
EEG_offsetfixed = highpass(EEG_denoised', 1, Fs, 'Steepness', 0.8)'; % remove DC offset
subplot(4, 1, 2)
plot(tval, EEG_offsetfixed')
xlabel('Time (ms)')
ylabel('Amplitude (uV)')
title('EEG trials after DC offset & line noise removal')

% Remove outliers
[EEG_outremoved, ind1] = EucOutRemove(EEG_offsetfixed, 0.3);
subplot(4, 1, 3)
plot(tval, EEG_outremoved')
xlabel('Time (ms)')
ylabel('Amplitude (uV)')
title('EEG trials after outlier removal')

% Denoise using subspace approach
EEG_subdenoised = SubSpaceDenoise(EEG_outremoved, 10);
subplot(4, 1, 4)
plot(tval, EEG_subdenoised')
xlabel('Time (ms)')
ylabel('Amplitude (uV)')
title('EEG trials after subspace denoised')
```
## 4.4 Power Spectrum
Applying the Fourier Transform: MATLAB provides functions such as fft or pwelch for calculating the power spectral density (PSD) estimate of the EEG signals. The Fourier transform is applied to each segment of the data to obtain the frequency-domain representation. Visualizing Power Spectra: Utilize MATLAB's plotting capabilities to visualize the power spectra. The PSD estimates can be plotted as a function of frequency, allowing you to observe the power distribution across different frequency bands. MATLAB's plot or spectrogram functions can be used for this purpose, providing customizable options for visualization. 

**Example Codes (FFT):**
```matlab
% Assuming you have preprocessed EEG data stored in the variable 'eegData'
% Segment length (in samples) and sampling rate (in Hz)
segmentLength = 1000;
samplingRate = 1000;

% Apply the Fourier Transform to each segment of the data
numSegments = floor(length(eegData) / segmentLength);
powerSpectra = zeros(segmentLength, numSegments);

for i = 1:numSegments
    segment = eegData((i-1)*segmentLength + 1 : i*segmentLength);
    powerSpectra(:, i) = abs(fft(segment));
end

% Assuming you have the power spectra stored in the variable 'powerSpectra'
% Frequency range (in Hz)
frequencyRange = linspace(0, samplingRate/2, segmentLength/2 + 1);

% Plotting the power spectra
figure;
plot(frequencyRange, mean(powerSpectra, 2)); % Average power spectra across segments
xlabel('Frequency (Hz)');
ylabel('Power');
title('Power Spectra');

% Alternatively, you can use the spectrogram function for a 2D representation
figure;
spectrogram(eegData, windowSize, overlap, frequencyRange, samplingRate, 'yaxis');
title('Spectrogram');
colorbar;
```

**Example Codes (Periodogram for PSD):**
```matlab
% Parameters for periodogram calculation
window = hamming(256); % Window function for spectral analysis
nfft = 512; % Number of FFT points
fs = 1000; % Sampling frequency of the EEG data

% Calculate periodogram
[Pxx, f] = periodogram(eeg_data, window, nfft, fs);

% Plot the power spectral density
figure;
plot(f, 10*log10(Pxx)); % Convert to dB scale for better visualization
xlabel('Frequency (Hz)');
ylabel('Power Spectral Density (dB/Hz)');
title('Power Spectral Density using Periodogram');
grid on;
```

## 4.5 Analyzing Frequency Bands:

Analyze specific frequency bands of interest to explore the neural oscillatory activity related to your research question. Common frequency bands include delta (0.5-4 Hz), theta (4-8 Hz), alpha (8-13 Hz), beta (13-30 Hz), and gamma (>30 Hz). MATLAB allows you to extract and quantify the power within these frequency bands using appropriate filtering or integration techniques.

**Example Codes:**
```matlab
$ Assume eeg_data is a trial by time matrix (each row is an eeg trial)

% Define frequency bands of interest
delta_band = [0.5 4]; % Delta frequency band (0.5-4 Hz)
theta_band = [4 8]; % Theta frequency band (4-8 Hz)
alpha_band = [8 13]; % Alpha frequency band (8-13 Hz)
beta_band = [13 30]; % Beta frequency band (13-30 Hz)
gamma_band = [30 100]; % Gamma frequency band (30-100 Hz)

% Apply bandpass filtering to extract frequency bands
delta_eeg = bandpass(eeg_data', delta_band, fs)'; % Delta band
theta_eeg = bandpass(eeg_data', theta_band, fs)'; % Theta band
alpha_eeg = bandpass(eeg_data', alpha_band, fs)'; % Alpha band
beta_eeg = bandpass(eeg_data', beta_band, fs)'; % Beta band
gamma_eeg = bandpass(eeg_data', gamma_band, fs)'; % Gamma band
```

## 4.6 Oscillatory Power and Phase 

### 4.6.1 Instantaneous Power and phase using Hilbert Transform with band-pass filtered EEG signals via `gete_ms`

By employing the Hilbert Transform with `gete_ms`, you can estimate the instantaneous power of EEG signals, allowing for further analysis of the temporal dynamics and power fluctuations in the neural activity. Follow previous steps, you can apply Hilbert transfrom to band-pass filtered EEG signals to obtain instantaneous power (signal power as a function of time). To compute the instantaneous power of EEG signals using the Hilbert Transform with `gete_ms`, you can follow these steps:

**Example Codes:**
```matlab
% Assume xxx_eeg is a trial by time matrix (each row is an eeg trial)
analytic_signal = hilbert(EEG);

% Apply hilbert transfrom to eeg signals in different frequency bands

theta_analytic = hilbert(theta_eeg')'; % Theta band analytical signal
gamma_analytic = hilbert(gamma_eeg')'; % Gamma band analytical signal

% get the power of signal amplitudes (envelopes)
theta_power = abs(theta_analytic).^2;
gamma_power = abs(gamma_analytic).^2;

% get the phase of the signals 
theta_phase = angle(theta_analytic);
gamma_phase = angle(gamma_analytic);

```

The resulting `xxx_power` will provide the time-varying power estimates for each event trial in the EEG data.


### 4.6.2 Time-Frequency Representation (Instantaneous Power and Phase by Frequencies) with `getphasepow`

As mentioned in the signal processing background section, time-frequency decomposition allows us to examine changes in various frequency components of a signal over time. This type of analysis is fundamental and can be performed using a critical function in the EEG toolbox called `getphasepow`. As the name suggests, this function calculates the phase and power values of a signal across all event trials in a time-frequency space using the Wavelet Transform.

Here's an example of using the `getphasepow` function:
```matlab
[phase, power] = getphasepow(21, events, 1800, 0, 500, 'filtfreq', [58 62], 'resampledrate', 500, 'freqs', freqs);
```

You may notice that the inputs for `getphasepow` are similar to those used in `gete_ms`. This is because `gete_ms` is called within `getphasepow` to extract the EEG snippets required for calculating the phase and power values for the specified channel. However, `getphasepow` also accepts an additional input called `freqs`, which is a vector of the frequencies of interest for identifying the phase and power values. This vector is typically generated using the Matlab expression `(2^(1/8)).^(8:n)`.

The resulting `phase` and `power` matrices provide information about the phase and power values at different frequencies and time points for the specified channel and events. The frequencies of interest are logarithmically spaced to provide more resolution in the lower frequency bands, as lower frequency ranges have smaller value ranges compared to higher frequency bands.

As you delve into more literature in the field, particularly studies involving rodents, you will encounter theories and findings based on changes in oscillatory power. Understanding the trends and implications of increased or decreased activities in different frequency bands in different brain regions during various memory paradigms will help you develop a better understanding of the expected results in your own analysis.

## 4.7 Connectivity Analysis
When performing connectivity analysis on EEG data, several measures can be utilized, including Phase-Locking Value (PLV), Cross-Phase Amplitude Coupling (xPAC), Phase-Amplitude Coupling (PAC), Coherence, and Correlation. Let's explore each of these measures briefly:

### 4.7.1 Phase-Locking Value (PLV)

PLV measures the phase synchronization between two EEG signals. It quantifies the consistency of phase relationships between different frequency components across trials or channels. PLV values range from 0 to 1, with higher values indicating stronger phase synchronization.

**Funciton (with shuffling)**

```matlab
% Inputs:
% X1 - filtered signal matrix from region 1, in a format of trials x times.
% X2 - filtered signal matrix from region 2, in a format of trials x times.
% NumShuffle - Number of shuffles in normalizing PLV.

% Outputs:
% PLV_norm: normalized Phase locking value (z-scored), showing PLV
% statistics against null distribution (e.g. significiantly phase locked).
% PLV_raw: raw phase locking value showing the absolute locking value
% between two phases, ranging from 0 to 1.

[PLV_norm,PLV_raw] = PLV_DW(X1,X2,NumShuffle)

```
[Click Here to see PLV_DW.m function](../src/connectivity/PLV_DW.m)


### 4.7.2 Cross-Phase Amplitude Coupling (xPAC) 

xPAC examines the relationship between the phase of one frequency band and the amplitude of another frequency band. It measures how the amplitude of a higher-frequency signal is modulated by the phase of a lower-frequency signal. xPAC is particularly useful for investigating interactions between different frequency ranges.

xPAC and PAC(following) shares the same computational procedures, and the differece is that xPAC uses amplitude and phase from two differnent regions whereas PAC uses amplitude and phase within the same region.
there are two method of computing PAC/xPAC:
```maltab
[M_norm_t,PfPha,totalMI,M_raw] = surr_norm(amplitude_t,phase_t)
```
[Click Here to see PAC_canolty.m function](../src/connectivity/PAC_canolty.m)
and 
```maltab
[MI_t,PfPha]=PAC_tort(phase_t,amplitude_t,nBins)
```
[Click Here to see PAC_tort.m function](../src/connectivity/PAC_tort.m)

### 4.7.3 Phase-Amplitude Coupling (PAC)

PAC assesses the coupling between the phase of one frequency band and the amplitude of the same or another frequency band. It captures how the amplitude of a signal at a specific frequency is modulated by the phase of another signal at a different frequency. PAC is commonly employed in studying functional interactions between oscillatory components.


### 4.7.4 Coherence
Coherence measures the linear relationship between two EEG signals across different frequencies. It quantifies the degree of synchronization or similarity in the phase and magnitude between two signals. Coherence values range from 0 to 1, with higher values indicating stronger linear relationships.

### 4.7.5 Correlation

Correlation is a widely used measure to assess the statistical relationship between two EEG signals. It quantifies the linear dependence between signals and ranges from -1 to +1. Positive values indicate a positive linear relationship, negative values indicate a negative linear relationship, and a value of zero indicates no linear relationship.

These measures provide different insights into connectivity patterns in EEG data. The choice of which measure to use depends on the research question, the specific hypotheses being tested, and the characteristics of the data. It is common to employ a combination of these measures to gain a more comprehensive understanding of the connectivity patterns in the brain.

Please note that these descriptions provide a brief overview, and the specific implementation and interpretation of these measures can vary depending on the research context.

```matlab
% Simulated EEG signals (replace with your actual EEG data)
eeg_signal_1 = randn(1, 100); % Replace with your EEG data
eeg_signal_2 = randn(1, 100); % Replace with your EEG data

% Calculate the mean of each signal
mean_signal_1 = mean(eeg_signal_1);
mean_signal_2 = mean(eeg_signal_2);

% Calculate the numerator of the correlation coefficient
numerator = sum((eeg_signal_1 - mean_signal_1) .* (eeg_signal_2 - mean_signal_2));

% Calculate the denominator of the correlation coefficient
denominator = sqrt(sum((eeg_signal_1 - mean_signal_1).^2) * sum((eeg_signal_2 - mean_signal_2).^2));

% Calculate the correlation coefficient
correlation_value = numerator / denominator;

% Display the correlation value
fprintf('Correlation coefficient between EEG signals: %.4f\n', correlation_value);

% Interpret the correlation value
if correlation_value > 0
    fprintf('Positive correlation: There is a positive linear relationship between the signals.\n');
elseif correlation_value < 0
    fprintf('Negative correlation: There is a negative linear relationship between the signals.\n');
else
    fprintf('No correlation: There is no linear relationship between the signals.\n');
end
```
This example code calculates the correlation coefficient using the formula for correlation coefficient. It then interprets the correlation value given the context within predetermined guidelines. Remember to replace the eeg_signal_1 and eeg_signal_2 variables with your actual EEG data.

## 4.8 Statistical Testing

Statistical testing plays a crucial role in research analysis by allowing us to make inferences about populations based on sample data. It helps determine the significance of observed differences or relationships and provides a framework for drawing conclusions from the data. In this section, we will discuss some common statistical tests used in this lab and provide additional resources for further understanding.

### 4.8.1 T-test

The t-test is used to compare means between two groups. It assesses whether the difference in means is statistically significant or likely to have occurred by chance. The t-test is applicable when the data follows a normal distribution and assumptions are met. Here is a resource that explains the t-test: [T-test YouTube Video](https://www.youtube.com/watch?v=0Pd3dc1GcHc&t=141s). The t-test is used to compare means between two groups. It assesses whether the difference in means is statistically significant or likely to have occurred by chance.

```matlab
% Perform independent samples t-test
group1 = [4, 5, 6, 7, 8];
group2 = [1, 2, 3, 4, 5];
[h, p, ci, stats] = ttest2(group1, group2);

% Display t-test results
disp(stats);
disp(['p-value: ' num2str(p)]);
```

### 4.8.2 Wilcoxon Rank-Sum Test

The Wilcoxon rank-sum test, also known as the Mann-Whitney U test, is a nonparametric test used to compare two independent groups when the assumptions for the t-test are not met. It evaluates whether there is a significant difference in the distribution of ranks between the groups. Here is a resource on the Wilcoxon rank-sum test: [Wilcoxon Rank-Sum Test YouTube Video](https://www.youtube.com/watch?v=nRAAAp1Bgnw&t=72s). The Wilcoxon rank-sum test, also known as the Mann-Whitney U test, is a nonparametric test used to compare two independent groups when the assumptions for the t-test are not met.

```matlab
% Perform Wilcoxon rank-sum test
group1 = [4, 5, 6, 7, 8];
group2 = [1, 2, 3, 4, 5];
[p, h, stats] = ranksum(group1, group2);

% Display rank-sum test results
disp(stats);
disp(['p-value: ' num2str(p)]);
```

### 4.8.3 Analysis of Variance (ANOVA)

ANOVA is a statistical test used to compare means across multiple groups or conditions. It determines whether there are significant differences between the means and provides information on which specific groups differ from each other. ANOVA assumes that the data follows a normal distribution and that variances are homogeneous. Here is a resource on ANOVA: [ANOVA YouTube Video](https://www.youtube.com/watch?v=-yQbZJnFXw&t=4s). NOVA is a statistical test used to compare means across multiple groups or conditions. It determines whether there are significant differences between the means.

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

### 4.8.4 Linear Mixed Effects Model

In addition to the previously mentioned statistical tests, another powerful tool for analyzing data with complex structures is the Mixed Effects Model. Mixed Effects Models, also known as Multilevel Models or Hierarchical Models, allow for the analysis of data with nested or clustered structures, such as repeated measures or data collected from different subjects.

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



