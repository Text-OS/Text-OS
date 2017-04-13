if "%~1" == "" goto invalid
if "%~2" == "" goto invalid
ren %1 %2
echo.
goto eof

:invalid
echo Not enough arguments.
:eof