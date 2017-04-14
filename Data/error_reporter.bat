if "%~1" == "" exit
if "%~2" == "" exit

cls
(echo %date% %time%)>> error.txt
(echo ---------------------------------------------------------------------------)>> error.txt
(echo Uh oh. There has been an error.)>> error.txt
(echo Friendly error message:)>> error.txt
(echo %1)>> error.txt
(echo AREA: %2 VARIABLES:)>> error.txt
(set TextOS.)>> error.txt
(echo ---------------------------------------------------------------------------)>> error.txt
(echo.)>> error.txt
notepad.exe error.txt

exit