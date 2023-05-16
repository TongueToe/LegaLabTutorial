%% 
%       Description: workingWithEvents.m is a MATLAB file that will walk you through
%       several basic examples of how to manipulate variables in MATLAB. This file
%       is what is known as a script. For more information on the different types
%       of files in MATLAB, you can reference the LegaLabTutorial.pdf file.
%       
%       There are several ways to work through this tutorial. One way to
%       work through it is to select the hyphen to the left of the first line that is 
%       not commented. Doing this will change the hyphen to a red circle which 
%       indicates a 'breakpoint'. If you hit 'Run' at  the top of this window, the 
%       code will Run until the first breakpoint. The code will execute all lines
%       BEFORE the breakpoint. The 'Run' button will now say 'Continue'. To
%       execute the next line, you can hit 'Step' which is next to 'Continue'. Hitting
%       'Continue' will execute all lines of code until the NEXT
%       breakpoint. Hitting 'Step' will continue through the code one line
%       at a time (moving a single line each time you hit 'Step'). To exit
%       out of a script type 'dbquit' in the Command Window. You can also
%       step through the code by typing 'dbstep' or 'dbcont'.
%
%       Last Updated: 11-17-2017 (Jui-Jui Lin)
%       Author: Jimmy Germi 
%
%


%% SECTION 1: Loading Events
%The first thing we will do is load an events structure. You will need to
%change this path to point to the location of the events file on your
%computer.

%change this to where your Tutorial_pkg is saved locally 
load('/Users/JL/Desktop/Tutorial_pkg/events.mat')

%filter out events with no time alignment 
events = filterStruct(events,'~strcmp(eegfile,'''')');

%This step is important. If the path is not fixed correctly, you wont be
%able to run the whole script
for n=1:length(events)
    
%change the second string to the local directory of the Tutorial_pkg
events(n).eegfile = regexprep(events(n).eegfile,'/project/shared/lega_ansir/subjFiles/UT014/eeg.reref','/Users/JL/Desktop/Tutorial_pkg');  

end


%       Now you can view the entries in 'events' for UT014. If you
%       double-click on the variable name in the MATLAB Workspace, a
%       Variable Viewer will open up. In this window, you can see the
%       fields in 'events' and the values for each of those
%       fields. The fields in events are explained in the
%       LegaLabTutorial.pdf file.

%       Each row in events.mat corresponds with 1 event. All of the fields
%       for a given row correspond to the same event. So row 25 is an event
%       for subject UT014, session 0, list 1, serial position 1 (the first
%       word of list 1), with type 'WORD' meaning word presentation, the
%       item presented was 'GLASS' which is item 111 in the word pool, that
%       item was later recalled (because recalled is 1), and so forth.

%% SECTION 2: Filtering Events
%In order to analyze the data collected, we will need to filter the data
%for the events we are interested in.

%Filtering method 1 - Extracting events:
%One of the easiest ways to filter events is to extract only those events
%we are interested in to create a smaller events structure. We first need
%to identify which events we want to look at using what is called a vector.

%Let's first extract all events that correspond to the first item presented
%in any list. To do this, we will need to look at the value of 'serialpos'.
%We can easily do this by extracting the 'serialpos' field from the events
%structure.
serialPositions = [events.serialpos];

%The variable serialPositions is a matrix with 1 row and 2015 columns. The
%columns correspond to events. So the value at serialPositions(1,278)
%should be the same as events(278).serialposition. Verify that this is the
%case.

%We can now check to see which serial positions are '1' by testing for
%equality. The double equal signs tests for equality and returns a logical
%(true (1) or false (0) ) indicating where the statement is true.
firstItem = serialPositions == 1;

%Like serialPositions, firstItem has 1 row and 2015 columns. Instead of
%having the actual serial positons of each event, firstItem just tells us
%whether an event had a serial position of 1 (true) or not (false). We can
%now use this as a vector index to filter our events. By indexing events
%using this vector, we will only get the events where the vector is true.
firstItemEvents = events(firstItem);

%Notice that the variable firstItemEvents has the same format as events but
%now we only have 75 entries. You can also see that the value for serial
%pos is 1 for every entry. Now, let's see what percent of the first items
%presented were remembered. We will first extract the values of the
%recalled field.
firstItemRecalled = [firstItemEvents.recalled];

%We now have a vector of ones where the item was remembered and zeros where
%it was not. To get a probability of recall, we will divide the number of
%items remembered by the total number of items.
numRec = sum(firstItemRecalled);

%The previous function added up all of the items that were remembered (sum
%of ones gives the number of items). You can see that 32 items were
%remembered. We will now get the length of the recalled vector to see how
%many total items there were.
numItems = length(firstItemRecalled);

%You can see that there were 75 items. We will divide the numRec by
%numItems to get a probability.
recProb = numRec / numItems;

%The subject remembered 42.67% of the first word presented in each list.

%Filtering Method 2: Using Several Vectors Simultaneously
%This method is slightly less intuitive because we will not generate a
%separate events structure for the events we care about but it is more
%computationally efficient. In this method, we will create several vectors
%that correspond to features of the events we are interested in. We will
%then analyze the events where all of the vectors are true.

%To demonstrate this, let's calculate the recall probability for the last
%item for every list but only for session 0. We will first create a vector
%identifying the events from session 0 and a second vector identifying the
%last word (serialpos = 12) from every list.
sess0vect = [events.session]==0;
item12vect = [events.serialpos] == 12;

%You can see that sess0vect is only true for the first 642 elements.
%Looking at events, you will see that the 643 event is for session 1 while
%all events before it are from session 0. However, if you look at
%item12vect, there are true values throughout the entire length. Using the
%& operator, we can find the events that are from session 0 AND correspond
%to serial pos 12.
sess0item12 = sess0vect & item12vect;

%Looking at sess0item12, you can see that true values only appear within
%the first 642 elements (session 0) and it is only true where serialpos was
%12. We can then filter the recalled values based on this vector.
sess0item12rec = [events(sess0item12).recalled];

%sess0item12rec has 25 elements (corresponding to the 12 serial position for the 25 lists in session
%0). We can then calculate the recall probability as we did for method 1.
recProb = sum(sess0item12rec) / length(sess0item12rec);

%For session 0, the subject remembered 32% of the last items presented in
%each list.

%% SECTION 3: Introducing for-loops:
% Before moving from behavioral analyses to EEG analyses, let's do a
% similar analysis to those performed above using a for-loop. The purpose
% of a for-loop is to automate an analysis several times changing the value
% of one variable each time. This example will also show you how to work
% with strings. In Matlab, strings are any letter or combinations of
% letters.

%Let's use a for-loop to find the number of words presented in each session
%and the number of recalls, prior list intrusions (PLI), extra list
%intrusisons (ELI) and vocalizations for each session.
%PLIs are any word that came from a previous list of presented words.
%ELIs were not on any list. Recalls are indicated
%by intrusion of 0, PLIs are indicated by intrusion of
%1, ELIs are indicated by intrusions of -1 and vocalizations are indicated
%by type 'REC_WORD_VV'.

%First, let's find how many sessions the subejct participated in and what
%the session numbers were using the MATLAB function 'unique'
sessNums = unique([events.session]);
numSess = length(sessNums);

%You can see the subject participated in 4 sessions (0, 1, 2 and 3). We
%will now create empty matrices of nan (not a numbers) where we will save
%the number of words presented, recalls, PLIs, ELIs, and vocalizations for
%each session. Creating an empty matrix that you will fill in using a
%for-loop is more efficient than resizing the matrix each time you loop
%through the for-loop. Each of these variables will have 1 row and 4
%columns with columns corresponding to the sessions.
numWords = nan(1,numSess);
numRecs = nan(1,numSess);
numELI = nan(1,numSess);
numPLI = nan(1,numSess);
numVocs = nan(1,numSess);

%We will now loop through each session filling in these values
for sessIndx = 1:numSess
    
    %The value of sessIndx will increase every time it reaches the 'end'
    %that terminates this loop. It will range from 1 to the number of
    %sessions increasing by 1 each time. Once the 'end' below is reached,
    %the code will return to the 'for' line and change the value of
    %sessIndx.
    
    %Although sessIndx will tell us what session index we should consider
    %in this loop, we want to know the session number. Our sessions are [0,
    %1, 2 and 3]. When sessIndx is 1, we want to look at session 0, 2 we
    %want to look at session 1 and so forth. To get the number, we will
    %access the session number at the index specified as below:
    thisSession = sessNums(sessIndx);
    
    %Remember, if you click on the dash to the left of a line, the code
    %will stop everytime it reaches that line and you can see how the value
    %of each variable changes.
    
    %We will now create a vector for the session being looped through.
    thisSessVect = [events.session] == thisSession;
    
    %We will now create a vector of words being presented (i.e. type: WORD)
    isWord = strcmp({events.type},'WORD');
    %Using the curly braces is often helpful when working with strings. To
    %see what this does, compare testCurly with testBracket below.
    testCurly = {events.type};
    testBracket = [events.type];
    
    %We will now delete these explanatory variables.
    clearvars('testCurly','testBracket')
    
    %The number of words for each session will be the sum of the session
    %vector & isWord.
    numWords(1,sessIndx) = sum(thisSessVect & isWord);
    %Notice that we save the number of words to a different column of the
    %numWords matrix each time we loop through sessions.
    
    %We will now repeat for the other counts
    recWords = [events.recalled] == 1;
    numRecs(1,sessIndx) = sum(recWords & thisSessVect);
    PLI = [events.intrusion]==1;
    numPLI(1,sessIndx) = sum(PLI & thisSessVect);
    ELI = [events.intrusion] == -1;
    numELI(1,sessIndx) = sum(ELI & thisSessVect);
    voc = strcmp({events.type},'REC_WORD_VV');
    numVocs(1,sessIndx) = sum(voc & thisSessVect);
end

%% SECTION 4: Analyzing EEG Signals
%In this section we will demonstrate how to use two functions from the EEG
%toolbox to analyze neural signals, namely gete_ms and getphasepow. In
%order to analyze the EEG data, you will need to modify the path specified
%in events.eegfile to point to the location of the EEG data on your
%computer.

%Now that the events structure points to the correct EEG file, we can
%analyze the EEG data for each event using the function gete_ms. In order
%for this to work, the eeg_toolbox/trunk must be in your path. To verify
%that it is in your path, navigate to the location of the LegaLabTutorial
%folder in the matlab file explorer. Then open the eeg_toolbox folder. If
%the trunk folder is not bolded, right click on it and select Add To
%Path>Selected Folders and Subfolders

%First we will analyze the EEG activity recorded at channel 1 for all
%events from 400 ms before the event to 1600 ms after the event began. This duration (including 0 ms) is 2001 ms. We
%will apply a notch filter at 58,62 Hz, resample to 200 Hz and subtract the
%activity from -400 to -200 ms.

eeg = gete_ms(101,events,2001,-400,0,[58 62],'stop',1,200,[-400 -200]);

%Notice that eeg has 2015 rows and 400 columns. The rows of the output
%correspond to events and the columns correspond to time. We used a 200 Hz
%resample rate (1000 ms/200 Hz = 5 ms per sample; 5 ms * 400 samples = 2000
%ms).  We will now plot the activity for the first event.

%The command 'figure' opens a new figure
figure
%The plot function takes the inputs x,y
%The first input to plot is the x-values (our times). Because the eeg has
%400 samples with a 5ms sample duration and our eeg signal was evaluated
%for 2000 ms beginning 400 ms before the event, our time range is from -400
%ms to 1600 ms counting by 5 ms at a time. 
times = -400:5:1600;
%Our y-values are out voltages obtained from eeg. We will only take the
%first row of voltages.
plot(times,eeg(1,:))
%We will label our x and y-axes with font size 12.
xlabel('time (ms)','FontSize',12)
ylabel('voltage','FontSize',12)
%We will title our plot with font size 16
title('Voltage Records at Channel 101 for Event 1','FontSize', 16)

%You can index the EEG output the same way you indexed events. We will now
%plot two lines. One for the average voltage for all recalled events and
%one for the average voltage for all not recalled events. You must make
%sure the events you use to create your filters are the same events that
%were input into gete_ms.
rec = [events.recalled] == 1;
nrec = [events.recalled] == 0;
%We will extract the voltages where rec is true
recEEG = eeg(rec,:);
%We will extract the voltages where nrec is true
nrecEEG = eeg(nrec,:);

%We will now plot EEG activity averaged over recalled and not recalled
%events
figure

%We will get the standard deviation and average along the first dimension (across recalled/not recalled
%events)
recSTD = nanstd(recEEG,[],1);
%We can convert the STD to standard error of the mean
%SEM = STD / sqrt(1 - N) where N is the number of observations
recSEM = recSTD / sqrt(1 - size(recEEG,1));

%We will average the voltages across all recalled events
recMean = nanmean(recEEG,1);

%We will plot the recalled EEG using a blue line
plot(times,recMean,'-b')
%hold all allows us to preserve the blue line and plot additional lines
hold all
nrecSTD = nanstd(nrecEEG,[],1);
%We can convert the STD to standard error of the mean
nrecSEM = nrecSTD / sqrt(1 - size(nrecEEG,1));
nrecMean = nanmean(nrecEEG,1);
%We will plot the average of not recalled voltages in red
plot(times,nrecMean,'-r')
xlabel('time (ms)','FontSize',12)
ylabel('voltage','FontSize',12)
title('Voltage Records at Channel 101 for Event 1','FontSize', 16)
%We will add a legend at the top right
legend({'Recalled','Not Recalled'},'location','northeast')
legend box off

%We can also plot these with error bars. Although the Errorbar function is
%not perfect, we will introduce you to better ways to display error bars
%later.
figure
errorbar(times,recMean,recSEM,'b')
hold all
errorbar(times,nrecMean,nrecSEM,'r')
xlim([-400 1600])

% h1 =shadedErrorBar(timeVect2,-Avg1,SEM1,'-b',true);
% h2= shadedErrorBar(timeVect2,-Avg2,SEM2,'-r',true);
% legend([h1.mainLine,h2.mainLine],'Left','Right');

%Note that you can also plot recalled and not recalled voltages by only
%passing recalled/not recalled events into gete_ms.
recEvents = events(rec);
eeg_for_rec_events = gete_ms(101,recEvents,2000,-400,0,[58 62],'stop',1,200,[-400 -200]);

%Notice that eeg_for_rec_events now only has 273 rows.

%We will now computer the power for channel 1 at specified frequencies  for
%the 1600 ms following the word onset using a 1500 ms buffer, a [58 62] Hz
%notch filter, and downsample to 500Hz 
freqs = (2^(1/8)).^(8:56);
[phase,power] = getphasepow(101,events,1600,0,1500,'filtfreq',[58 62],'freqs',freqs);

%We now have a 3D matrix for phase and power. The dimensions correspond to
%events x freq x time. We will now plot the recalled and not recalled power
%averaged over time and across events. We first filter by rec/nrec, average
%acorss time (3rd dimension), squeeze this to eliminate dimensions that
%only have 1 element, then average across events (1st dimension)
timeAvgRecPow = nanmean(squeeze(nanmean(power(rec,:,:),3)),1);
timeAvgNonPow = nanmean(squeeze(nanmean(power(nrec,:,:),3)),1);

%We will now plot the time averaged power
figure
plot(freqs,timeAvgRecPow','-g')
hold all
plot(freqs,timeAvgNonPow','-r')
ylabel('Power')
xlabel('Freq (Hz)')
title('Raw power for UT014 ch101 averaged across Time')

%Notice that it is difficult to interpret the curves (esp. for higher
%freq). We will try to address this by plotting -log(pow) 
timeAvgRecPow = nanmean(squeeze(nanmean(-log(power(rec,:,:)),3)),1);
timeAvgNonPow = nanmean(squeeze(nanmean(-log(power(nrec,:,:)),3)),1);
figure
plot(freqs,timeAvgRecPow','-g')
hold all
plot(freqs,timeAvgNonPow','-r')
ylabel('Power')
xlabel('Freq (Hz)')
title('Power for UT014 ch101 averaged across time')

%We can also display the log power without averaging over time using a
%spectogram
recPow = squeeze(nanmean(-log(power(rec,:,:)),1));
nonPow  = squeeze(nanmean(-log(power(nrec,:,:)),1));

%We will generate the time-freq plot using contourf
figure
contourf(1:1600,freqs,recPow,length(freqs),'edgecolor','none')
set(gca,'yscale','log','ytick',[2.^(1:8)]);
%We will add a colorbar indicating the numerical value of each color
h=colorbar;
h.Label.String = '-log(pow)';
h.Label.FontSize = 14;
%We specify the colorscheme to use
colormap(jet)
xlabel('time (ms)')
ylabel('freq (Hz)')
set(gca,'fontsize',14')
title('Recalled Power for UT014 ch 101','FontSize',16)

%You may have noticed that it is difficult to compare effects at different
%frequencies. This is related to the 1/freq effect of power where higher
%frequencies have less power (or higher -log(pow)). If we, instead, plot
%the power relative to some baseline, the effects at different frequencies
%are more easily interpreted. Instead of a standard baseline, let's look at
%the comparison of recalled and not recalled power using a t-test. While
%the statistical validity of this is dubious, we will use the t-test in
%this example for simplicity. The difference between encoding activity for
%words that are later remembered or forgotten is known as a subsequent
%memory effect (SME).
[~,SME_p_value] = ttest2(power(rec,:,:),power(nrec,:,:),'tail','right');

%To plot this, we can convert the p-value to a t-stat using the -norminv
%function. We will first make sure to reduce extreme p-values
SME_p_value(SME_p_value < 0.0001) = 0.0001;
SME_p_value(SME_p_value > 0.9999) = 0.9999;
SME_t = -norminv(squeeze(SME_p_value));

%Now we will plot the SME_t
figure
contourf(1:1600,freqs,SME_t,length(freqs),'edgecolor','none')
set(gca,'yscale','log','ytick',[2.^(1:8)]);
h=colorbar;
h.Label.String = 'SME t-stat';
caxis([-4 4])
h.Label.FontSize = 14;
colormap(jet)
xlabel('time (ms)')
ylabel('freq (Hz)')
set(gca,'fontsize',14')
title('T-test Comparing Rec and Non Rec Power for UT014 ch 101','FontSize',16)

%We can also only plot the values where the SME is significant (p<0.05 or p>0.95)
[~,SME_p_value] = ttest2(power(rec,:,:),power(nrec,:,:),'tail','right');
SME_p_value = squeeze(SME_p_value);
sigSME = SME_p_value < 0.05 | SME_p_value > 0.95;
%To plot this, we can convert the p-value to a t-stat using the -norminv
%function. We will first make sure to reduce extreme p-values
SME_p_value(SME_p_value < 0.0001) = 0.0001;
SME_p_value(SME_p_value > 0.9999) = 0.9999;
SME_t = -norminv(SME_p_value);
%We will convert our SME_t that are not significant to nan
SME_t(~sigSME) = nan;

%Now we will plot the SME_t that are significant
figure
contourf(1:1600,freqs,SME_t,length(freqs),'edgecolor','none')
set(gca,'yscale','log','ytick',[2.^(1:8)]);
h=colorbar;
h.Label.String = 'SME t-stat';
caxis([-4 4])
h.Label.FontSize = 14;
colormap(jet)
xlabel('time (ms)')
ylabel('freq (Hz)')
set(gca,'fontsize',14')
title('T-test Comparing Rec and Non Rec Power for UT014 ch 101 (p<0.05)','FontSize',16)

%Interpreting this figure, we can see that there is significantly more 3-32
%Hz power from 0-200 ms and from 1400-1600 ms for recalled events than not recalled events for this electrode.
%We also see less 32-64 Hz activity from 0-100 ms for recalled events.
%There is less 64-128 Hz activity from 200-400 ms for recalled events which
%is followed by relatively more 64-128 Hz activity for recalled events from
%400-600 ms.

% %Channel 1 was in the anterior hippocampus. We can now repeat the analysis
% %for the posterior hippocampus (channel 43) and see how it compares.
% clearvars('-except','events','freqs')
% [phase,power] = getphasepow(43,events,1600,0,1500,'freqs',freqs,'filtfreq',[58 62],'filttype','stop');
% 
% rec = [events.recalled] == 1;
% nrec = [events.recalled] == 0;
% 
% [~,SME_p_value] = ttest2(power(rec,:,:),power(nrec,:,:),'tail','right');
% SME_p_value = squeeze(SME_p_value);
% sigSME = SME_p_value < 0.05 | SME_p_value > 0.95;
% 
% SME_p_value(SME_p_value < 0.0001) = 0.0001;
% SME_p_value(SME_p_value > 0.9999) = 0.9999;
% SME_t = -norminv(SME_p_value);
% 
% SME_t(~sigSME) = nan;
% figure
% contourf(1:1600,freqs,SME_t,length(freqs),'edgecolor','none')
% set(gca,'yscale','log','ytick',[2.^(1:8)]);
% h=colorbar;
% h.Label.String = 'SME t-stat';
% caxis([-4 4])
% h.Label.FontSize = 14;
% colormap(jet)
% xlabel('time (ms)')
% ylabel('freq (Hz)')
% set(gca,'fontsize',14')
% title('T-test Comparing Rec and Non Rec Power for UT014 ch 43 (p<0.05)','FontSize',16)

