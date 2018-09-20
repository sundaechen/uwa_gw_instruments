clc

fileID = fopen('params.txt');
C = textscan(fileID,'%s %s');
fclose(fileID);
celldisp(C)


