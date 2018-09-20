clear

fileTemp = dir('m*.txt');
dataAll = [];

for fn = 1:size(fileTemp,1)
    fid = fopen(fileTemp(fn).name, 'rt');
    Temp = textscan(fid, '%f');
    datatemp = Temp{1};
    fclose(fid);
    len = size(datatemp,1)/2;
    data = zeros(len,2);
    
    for i = 1:len
        data(i,1) = datatemp(i*2-1);
        data(i,2) = datatemp(i*2);
    end
    
    dataAll = [dataAll; data];
end

datasave = [real(dataAll(:,1)), real(dataAll(:,2)), imag(dataAll(:,2))];

save -ascii data_20141007.txt datasave