% % can be used to get Q for 2 peaks%
% Q1xls = [];
% Q2xls = [];
% P1xls = [];
% P2xls = [];
global c
global a
global a1
global a2
global b
global b1
global b2
global vEnd

global selectpeak
% for i = 1:size(Ctemp)
    disp(['       ', Ctemp(i).name]);
    
    figure(1)
    clf reset
    semilogy(X(:,i),Y(:,i),'-ok','MarkerSize',5)
    grid on
    hold on
    pause
    
    %% fit the highest peak %%   
    f1 = 1;
    f2 = size(Y(:,i),1);
    
%% save frequency and Q
% q1temp = vEnd(3);
% ffit = vEnd(4);
% p1temp = [vStart(4),vStart(2): Vend(4),vEnd(2)];
% Q1xls = [Qlxls,ffit,q1temp];

% Q1xls = [Q1xls,q1temp];
% P1xls = [P1xls,p1temp];
%% Choose 2 peaks or three peaks
% run 3 peaks as it continues and run 2 peaks in a qget2peaks.m file

selectpeak = input('How many peaks does the data have? Three peaks=3 / Two peaks=2 / One peak=1 :');

        while (size(selectpeak) == 0)
                selectpeak = input('How many peaks does the data have? Three peaks=3 / Two peaks=2 / One peak=1 :');
        end
            
            
                          
            if selectpeak == 3

                run getqs2
            
            
            elseif  selectpeak == 2
                
                run tp

            elseif  selectpeak == 1
                run qq
            else
                disp('Error!!')
            end
            
               
            
