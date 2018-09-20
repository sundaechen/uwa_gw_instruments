
% clear

% run getdata

% num_of_files = size(Ctemp,1);

result = [];
global selectpeak 

for all = 1:4 % num_of_files
    i = all;
    clear fitresults
    run qget
    if (selectpeak ==2)
        
        if (b < b1)
            
            fitresults = [all, b, abs(vEndx(1)), vEndx(4),0, b1, abs(vEndx(2)), vEndx(3)];
      
        elseif (b > b1)
        
            fitresults = [all, b1, abs(vEndx(2)), vEndx(3),0, b, abs(vEndx(1)),vEndx(4)];
      
        else
            
            disp('ERROR!');
        
            fitresults = [0,0,0,0,0,0,0,0];
      
        end
       
    elseif (selectpeak ==3)

        fitresults = [all, b, vEnd(1), a, 0,0,0,0];
        pause
        
    elseif (selectpeak ==1)

        fitresults = [all, b, vEnd2(1), a, 0,0,0,0];
        pause
    
    elseif (selectpeak == 0)
        fitresults = [0,0,0,0,0,0,0,0];
        print('Skip this curve!')
        
    end
    
    
        result = [result;fitresults];
        
        pause

end