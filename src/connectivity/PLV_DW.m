% This function computes trial-by-trial Phase-Locking Value (PLV) between
% two regions.
%
% [PLV_norm,PLV_raw] = PLV_DW(X1,X2,NumShuffle)
% Inputs:
% X1 - filtered signal matrix from region 1, in a format of trials x times.
% X2 - filtered signal matrix from region 2, in a format of trials x times.
% NumShuffle - Number of shuffles in normalizing PLV.
%
% Outputs:
% PLV_norm: normalized Phase locking value (z-scored), showing PLV
% statistics against null distribution (e.g. significiantly phase locked).
% PLV_raw: raw phase locking value showing the absolute locking value
% between two phases, ranging from 0 to 1.
% Both PLV_norm and PLV_raw are one value (averaged across time in the process)
% per two phase trial, in a vector with length of number of trials.
%
% Latest update : June 2022
% David Wang



function [PLV_norm,PLV_raw] = PLV_DW(X1,X2,NumShuffle)

% get instantaneous phase from filtered signal matrix
Phase1 = angle(hilbert(X1')');
Phase2 = angle(hilbert(X2')');

NumTrial = size(X1,1);

PLV_norm = zeros(1,NumTrial);
PLV_raw = zeros(1,NumTrial);

for i = 1: NumTrial
    
    phase1 = Phase1(i,:);
    phase2 = Phase2(i,:);
    % compute raw phase locking value
    zn = exp(1i*(phase1-phase2));
    plv_raw = abs(mean(zn));
    
    %% compute shuffle values
    numpoints=length(phase1);
    minskip=50;
    maxskip=numpoints-50;
    skip=ceil(numpoints.*rand(NumShuffle*2,1));
    skip(skip>maxskip)=[];
    skip(skip<minskip)=[];
    skip=skip(1:NumShuffle,1);
    surrogate_plv=zeros(NumShuffle,1);
    
    for s=1:NumShuffle
        surrogate_phase=[phase1(skip(s):end) phase1(1:skip(s)-1)];
        surrogate_plv(s) = abs(mean(exp(1i*(surrogate_phase-phase2))));
        
    end
    
    % fit gaussian to shuffled data, uses normfit.m from MATLAB Statistics toolbox
    [surrogate_mean,surrogate_std]=normfit(surrogate_plv);
    % normalize PLV (z-score) using shuffled data (null distribution)
    plv_norm=(plv_raw-surrogate_mean)/surrogate_std;
    
    PLV_norm(i) = plv_norm;
    PLV_raw(i) = plv_raw;
end

end
