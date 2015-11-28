@echo off
title Guess The Number
setlocal enabledelayedexpansion

if not defined TextOS.BootedFromTextOS exit

set GuessTheNumber.Version=0.7
set GuessTheNumber.Debug=0

if exist set_debug set GuessTheNumber.Debug=1

:menu
cls
echo Guess The Number^^!
echo.
::!Selection! "Start" "Exit to TextOS"
cmdmenusel f870 "Start" "Exit to TextOS"

if %errorlevel% == 1 goto Intro
if %errorlevel% == 2 exit /b

:Intro
set GuessTheNumber.Number=%random%
set GuessTheNumber.AImsg=Hello^^! Now, try to guess the number I'm thinking of. 
:: DEBUG: !GuessTheNumber.Number!
:TheGame
cls
set /a GuessTheNumber.Tries+=1
echo !GuessTheNumber.AImsg!
echo.
set/p GuessTheNumber.Input=Guess The Number: 

if !GuessTheNumber.Input! LSS !GuessTheNumber.Number! set GuessTheNumber.AImsg=Higher^^! && goto TheGame
if !GuessTheNumber.Input! EQU !GuessTheNumber.Number! goto YouWon
if !GuessTheNumber.Input! GTR !GuessTheNumber.Number! set GuessTheNumber.AImsg=Less^^! && goto TheGame

:YouWon
cls
echo You won^^!
echo You had !GuessTheNumber.Tries! until you found the correct one^^!
echo And the number was !GuessTheNumber.Number!.
pause >nul
goto menu


:: 2160p == 4K
:: 1440p == HD
:: 1080p == HD
:: 720p  == HD
:: 480p  == SD
:: 360p  == SD
:: 240p  == SD
:: 144p  == LD