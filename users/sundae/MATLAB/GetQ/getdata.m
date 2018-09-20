% % get data from trace**.txt and put into a text file
% % get data for Q fitting

clear all

Ctemp = dir('TRACE*.txt');
X = [];
Y = [];
XY = [];
for i = 1:size(Ctemp,1)
    data = load(Ctemp(i).name);
    xtemp = data(:,1);
    X = [X,xtemp];
    if size(data,2) == 2
        ytemp = data(:,2);
    elseif size(data,2) == 3
        ytemp = sqrt(data(:,2).^2+ data(:,3).^2);
    else
        ytemp = i
    end
    Y = [Y,ytemp];
    XY = [XY,xtemp,ytemp];
    clear data;
end
% X11 = [];
% X44 = [];
% Y11 = [];
% Y44 = [];
% for i = 1:size(Ctemp,1)
%     if X(1,i)<1000000
%         X11 = [X11,X(:,i)];
%         Y11 = [Y11,Y(:,i)];
%     elseif X(1,i)>1000000
%         X44 = [X44,X(:,i)];
%         Y44 = [Y44,Y(:,i)];
%     end
% end

save data.txt XY -ascii

% filename = [];
% for i = 1:size(Ctemp,1)
%     filename = [filename;[Ctemp(i).name repmat(' ',1,13-length(Ctemp(i).name))]];
% end

filename = [];
for i = 1:size(Ctemp,1)
    filename = [filename,[Ctemp(i).name repmat(' ',1,13-length(Ctemp(i).name))] '000000000001 '];
end

% tryname = {};
% for i = 1:3
%     tryname(i) = {Ctemp(i).name};
% end