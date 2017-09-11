@echo off

if "%~1" == "" goto errorerror
if "%~2" == "" goto errorerror

cls
(echo %date% %time%)>> error.txt
(echo ---------------------------------------------------------------------------)>> error.txt
(echo Uh oh. There has been an error.)>> error.txt
(echo Friendly error message:)>> error.txt
(echo %1)>> error.txt
(echo AREA: %2 VARIABLES:)>> error.txt
(set TextOS.)>> error.txt
(echo ---------------------------------------------------------------------------)>> error.txt
notepad.exe error.txt
goto exit

:errorerror
echo I'm real serious. Not even Needle doesn't believe me. You better do. There was 
echo an error with the error reporter. Coiny and Pin thinks it's an inception joke. 
echo But it isn't. Please. Report this bug!
echo Report this at http://github.com/Text-OS/Text-OS. I am counting on you.
pause

:exit
exit