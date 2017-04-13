REM :loadprogram
REM echo.
REM echo You are in LoadProgram mode.
REM set/p TextOS.LoadProgramInput=Enter filename (put it in the "Data" folder, and exluding file extension):
REM echo.
REM if not exist !TextOS.LoadProgramInput!.bat echo Could not find the file. && !Timeout! 4 >nul && goto loadprogram
REM call !TextOS.LoadProgramInput!
REM goto menu