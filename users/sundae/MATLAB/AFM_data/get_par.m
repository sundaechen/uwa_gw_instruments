function param = get_par(cell,str)
    k = strfind(cell, str);
    param = cell(~cellfun(@isempty,k));
    param = regexp(param{1},'\d*','Match');
	
    if size(param,2)==1
        param = str2double(param{1});
    elseif size(param,2)==2
        p1 = str2double(param{1});
        p2 = str2double(param{2})/10^(length(param{2}));
        param = p1+p2;
    end    
end

%     k = strfind(A.textdata, 'ScanWidth');
%     param = A.textdata(~cellfun(@isempty,k));
%     param = regexp(param{1},'\d*','Match');
%    

