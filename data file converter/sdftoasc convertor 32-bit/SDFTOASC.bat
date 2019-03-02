@echo off

IF EXIST *.dat GOTO start

echo Error, there are no *.dat files in the current directory

goto end

:start

ren *.dat *.da

IF EXIST *.txt ren *.txt *.dat

FOR %%F in (*.da) DO Sdftoasc.exe /O %%F %%Ft

IF EXIST *.dat goto finalise

echo Error, no files converted

goto finalise2

:finalise

ren *.dat *.txt

echo Files converted sucessfully

:finalise2

ren *.da *.dat

:end

pause