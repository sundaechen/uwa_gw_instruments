k = get_num(A.textdata, 'PointsPerLine');
% points = A.textdata(~cellfun(@isempty,k));
% points = regexp(points,'\d*','Match');
% points = str2double(points{1})
% 


function num = get_num(cell,str)
    k = strfind(cell, str);
    num = cell(~cellfun(@isempty,k));
    num = regexp(num,'\d*','Match');
    num str2double(points{1});
end

A.PointsPerLine = get_num(A.textdata, 'PointsPerLine');