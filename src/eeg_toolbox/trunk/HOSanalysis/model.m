
classdef model 
%
%  Regressor object for point-process models. 
% 
%  out=model(Response,RegIn,varargin)
%
%  Response is a struct with two fields:
%       .dat : Response data
%       .type: data type : 'binary' for binary data,'count' for count
%                          data,'times' for event times.
%       .fs : sampling rate.
% 
%  RegIn is a struct describing the independent variables.
%       .autodep: How to model the conditional dependence on the process history
%                 using a laguerre polynomial expansion. It should be a struct
%                 array with the following fields:
%                    .order: order of the expansion.
%                    .tau:   time constant.
%                 An empty array indicates no modeling of conditional dependence;
%                 with no dependence, statistical results are valid only if the
%                 process is Poisson. Default is
%                 .autodep = struct('order',{0 2},'tau',{0 .05 });

% C. Kovach 2019

    properties

       response;
       labels;
       modelType= 'binomial';
       autodep = struct('order',{0  2},'tau',{0 .05});
       event = struct('times',[],'types',[],'Trange',[]);
       sampling_rate;
       Tstart=0;
       timeBasis = 'polynomial';
       timeOrder = 6;
       regressors;
       fact2reg_args = {};
    end

    properties( Dependent = true)
       designMtx 

    end

    methods

        function me = model(Y,fs,varargin)
          
            if isscalar(Y)
                N = Y;
                Y=[];
            else
                N = length(Y);
            end

            me.response = Y;          
          
            me.sampling_rate = fs;

            i = 1;

            while i < length(varargin)

                switch(varargin{1})

                    case {'modelType','Tstart','autodep','event'}
                        out.(varargin{i}) = varargin{i+1};
                        i=i+1;
                    case {'eventTimes','eventTypes'}
                        fldn = lower(regexprep(varargin{i},'event',''));
                        me.event.(fldn) = varargin{i+1};
                    case 'Trange'
                         out.event.(varargin{i}) = varargin{i+1};
                    otherwise
                        if ~ischar(varargin{i})
                            error('Expecting a keyword string, found a %s object instead.',class(varargin{i}));
                        end
                        error('%s is an unrecognized keyword.',varargin{i});
                end
                i=i+1;
            end
                
        end
        
        function out=get.designMtx(me)
            %%% Get the design matrix
            
            %%% History regressor
            if ~isempty(me.autodep)
                 histreg = regressor(laguerreFilt(me.response,me.autodep,me.sampling_rate),'historyLaguerre');
            else
                histreg = [];
            end
            %%% Factorial model
            Fs = zeros(size(me.response,1),length(me.event));
            for k = 1:length(me.event)
                [T,tt] = chopper(me.event(k).Trange,me.event(k).times,me.sampling_rate);
                evs = permute(me.event(k).evnt,[3 1 2]);
                evs = repmat(evs,size(T,1),1);
                F = zeros(size(me.response,1),size(me.event(k).evnt,1));
                F(T,:) = evs;
                %Indicate times to be ignored outside the regression window
                mask = true(size(F));
                F(T) = false;
                if isfield(me.event(k),'center')
                    center = me.event(k).center;
                else
                    center = [];
                end
                if isfield(me.event(k),'label')
                    label = me.event(k).label;
                else
                    label = sprintf('Factor %i',k);
                end    
                if isfield(me.event(k),'fact2reg_args')
                    fact2regs_args = me.event(k).fact2regs_args;
                else
                    fact2regs_args={};
                end
                
                if ~iscell(label)
                    label = {label};
                end
                Fs(:,k) = F;
                
                
             
                Freg = fact2reg(Fs,'center',center,'ignore',mask,'labels',label,me.fact2reg_args{:});


                %%%
                switch me.timeBasis
                    case 'polynomial'
                        timeOrder = [];
                        if isfield(me.event(k),'timeOrder')
                            timeOrder = me.event(k).timeOrder;
                        end
                        if isempty(timeOrder) %#ok<*PROP>
                            timeOrder = me.timeOrder;
                        end
                        P = repmt(chebyt(length(tt),timeOrder),size(T,2),1);
                        TP = zeros(size(me.response,1),size(P,2));
                        TP(T(:),:) = P;
                        
                        Treg = regressor(TP,'label',sprintf('Window %i time',k));
                        me.regressors(end+1)=interaction(Freg,Treg);
                    case 'boxcar'
                        error('Boxcar time basis is not implemented yet')
                    otherwise
                        error('%s is an unrecognized option for the time basis.')
                end
            end   
        end
        
        function addregressor(me,regIn)
           
            
            
        end
        
    end
end

