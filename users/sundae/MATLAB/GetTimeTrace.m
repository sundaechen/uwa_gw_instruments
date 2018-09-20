
clear all
%
%  Specifically for Wed 21 sept, TT1E1 --2--3--4 
%       379 253.8 kHz = Center frequency = Fixed Sine source = Resonance 
%             to best of my knowledge
%       Source 0.1mV
%         Span 2 kHz        
%      Visual Tau was around 36 ms, for a Q of 43 000, compared to 42 000 from FX.dat
%

freq = 31464; %269.42; % resonant frequency (Hz)

Ctemp = dir('RACE22.txt');
TimeArr = [];
AmplArr = [];
for i = 1:size(Ctemp,1)
    data = load(Ctemp(i).name);
    xtemp = data(:,1);
    TimeArr = [TimeArr,xtemp];
    if size(data,2) == 2
        ytemp = data(:,2);
    elseif size(data,2) == 3
        ytemp = sqrt(data(:,2).^2+ data(:,3).^2);
    else
        ytemp = i;
    end
    AmplArr = [AmplArr,ytemp];
    clear data;
end

NumbFiles = size(Ctemp,1);

pick =1; %  input(['Which  file would you like to load? Between 1 and ',num2str(NumbFiles),' : ']);

if (pick > NumbFiles)
      pick = NumbFiles;
elseif (isempty(pick)|| pick <1)
    pick = 1;
end

Time = TimeArr(:,pick);
Ampl = AmplArr(:,pick);
disp(['    file name: ',Ctemp(pick).name])

clear  Ctemp TimeArr AmplArr ytemp xtemp



%%%%%%%%%%%%%%%%%   line 36
%
%   These commands will get you the fit parameters
%   Y(t) = Ao*exp(-(t-t_0)/TAU) + C_0
%
%  You will then have to fit the data
%  from [Time(t_0) to Time(A_lgt)
%  to Obtain TAU. Then compute Q- Factor: Q = pi*TAU*Frequency
%%%%%%%%%%%%%%%%%
A_temp = sort(Ampl,'descend');
A_i = A_temp(1:5);
%A_i = Ampl(1:50);

A_lgt = length(Ampl);
A_f = Ampl(A_lgt-10:A_lgt);
AVg_i = mean(A_i);
AVg_f = mean(A_f);

G_2 = (AVg_i-AVg_f)/2;
I_t2 = find(abs(Ampl - G_2) < 1.0e-4);

sp = 0;

if(isempty(I_t2)) I_t2 = find(abs(Ampl - G_2) < 1.0e-1);
    sp =1;
end 

disp(['sp = ',num2str(sp)])          

  %%%%   when sp=1, 
  %%%%   a different tolerance must be used.

I_t = I_t2(length(I_t2));
disp(['End point: ',num2str(I_t)]);

%I_t2

tol2= 2e-5;

if(sp)  tol2 = 7e-2;   
 end

while((abs(Ampl(I_t)-AVg_i))>tol2 & I_t>1)
           I_t = I_t -1;
end


disp(['Start point: ',num2str(I_t)])

 A_0 = Ampl(I_t);  % starting Amp
 t_0 = Time(I_t); % starting time
 C_0 = AVg_f;   % noise floor
fprintf('  A_0 = %f \n  t_0 = %f \n  noise = %f \n',A_0,t_0,C_0);

clear A_i A_f I_t2
 
% These are the 3 fixed parameters that you need.
% then Fit data to find TAU

clf reset

%% tau fitting
% plot(Time,Ampl,'.b','MarkerSize',7)
semilogy(Time,Ampl,'.b','MarkerSize',7)
grid on
YL = ylim;
% ylim = ([min(Ampl) max(Ampl)])
hold on
% pause
includs = excludedata(Time,Ampl,'domain',[0 t_0]);
ylim(YL)
plot(Time(~includs),Ampl(~includs),'.g', 'MarkerSize',7)
legend('raw data','exclude data');
% pause
%% exclding rules
ex_ = false(length(Time),1);
ex_([]) = 1;
ex_ = ex_ | (Time <= t_0);
ok_ = isfinite(Time) & isfinite(Ampl);
%% estimate tau
atemp = 0.3*(A_0 - C_0);
a1 = A_0 - atemp;
a2 = a1 / exp(1);

t1 =Time(find(Ampl >= a1,1,'last'));
t2 =Time(find(Ampl <= a2,1));
tau_0 = t2-t1;

st_ = [A_0, C_0, t_0, tau_0]; % start point

ft_= fittype('a*exp(-(x-t0)/tau)+c',...
    'dependent',{'y'},'independent',{'x'},...
    'coefficients',{'a', 'c', 't0', 'tau'});

cf_ = fit(Time(ok_),Ampl(ok_),ft_,'Startpoint',st_,'Exclude',ex_(ok_));

%% plot fit
plot(cf_,'fit',0.95)

%% save fit data
tau = cf_.tau;

Q = freq*pi*tau;

disp(['tau = ',num2str(tau)])
disp(['Q = ',num2str(Q)])




