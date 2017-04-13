if "%~1" == "" goto invalid
mkdir %1
echo.
goto eof

:invalid
echo Not enough arguments.
:eof