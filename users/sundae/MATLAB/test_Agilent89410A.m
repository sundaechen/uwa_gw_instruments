%% https://au.mathworks.com/help/instrument/communicating-with-your-instrument_f12-22207.html

s = gpib('agilent',7,19);
set(s,'OutputBufferSize',9223)
fopen(s)
fprintf(s,'*IDN?')
out = fscanf(s);

fclose(s)

fprintf(s,'syst:err?')
out = fscanf(s)

fprintf(s,'calc1:data?')
out = fscanf(s)
out = query(s,'calc1:data?')