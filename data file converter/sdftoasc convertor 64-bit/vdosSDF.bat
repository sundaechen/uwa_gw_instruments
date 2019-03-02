@echo off


IF EXIST *.dat GOTO start


echo Error, there are no *.dat files in the current directory


goto end


:start


ren *.dat *.da


IF EXIST autoexec.txt ren autoexec.txt autoexec.old
IF EXIST *.txt ren *.txt *.dat

FOR %%F in (*.da) DO call vdosloop %%F
IF EXIST autoexec.txt del autoexec.txt
IF EXIST autoexec.old ren autoexec.old autoexec.txt
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