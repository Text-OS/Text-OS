IF "%~1" == "" goto noarg1
color %1
set colorcode=%1
goto eof

:noarg1
call helpcolor.bat
:eof