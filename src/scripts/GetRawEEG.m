% power estimation template 
% David Wang  

clear;
clc;
close all;

addpath(genpath('../../src/eeg_toolbox'));
EEGdata=('../../behData/UT014//behavioral/FR1/session_0/events.mat');
load(EEGdata);

encodingevents=events(strcmp({events.type}, 'WORD'));
recalled=encodingevents([encodingevents.recalled]==1);
nonrecalled=encodingevents([encodingevents.recalled]==0);

electrode_num = [77];

Fs = 500;
tval = linspace(0,1800,1.8*Fs);
% get raw EEG trials
EEG = gete_ms(electrode_num,recalled,1800,-0,200);
EEG = resample(EEG',Fs,1000)';
% step 1 investigate raw trials
figure('position',[20 20 600 900])
plot(tval,EEG')
xlabel('Time (ms)')
ylabel('Amplitude (uV)');title('Raw EEG trials')
