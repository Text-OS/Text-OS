if "%~1" == "" goto invalid
if not exist %1 (
	echo File not found.
	goto eof
)
del %1
echo Deleted !TextOS.VDisk_DelInput! successfully^^!
echo.
goto eof

:invalid
echo Not enough arguments.
:eof