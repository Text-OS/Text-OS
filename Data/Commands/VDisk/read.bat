if "%~1" == "" goto invalid
if not exist %1 (
	echo File not found.
	goto eof
)
type %1
echo.
goto eof

:invalid
echo Not enough arguments.
:eof