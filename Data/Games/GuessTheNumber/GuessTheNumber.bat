@echo off
title Guess The Number
setlocal enabledelayedexpansion

if not defined TextOS.BootedFromTextOS exit

set GTN.Version=0.8

:menu
cls
echo Guess The Number^^!
echo.
!Selection! "Start" "Exit to TextOS"
::cmdmenusel f870 "Start" "Exit to TextOS"

if %errorlevel% == 1 goto Intro
if %errorlevel% == 2 exit /b
goto menu

:Intro
set GTN.Number=%random%
set GTN.AImsg=Hello^^! Now, try to guess the number I'm thinking of. 
:: DEBUG: !GTN.Number!
:TheGame
cls
set /a GTN.Tries+=1
echo !GTN.AImsg!
echo.
set/p GTN.Input=Guess The Number: 

if !GTN.Input! LSS !GTN.Number! set GTN.AImsg=Higher^^! && goto TheGame
if !GTN.Input! EQU !GTN.Number! goto YouWon
if !GTN.Input! GTR !GTN.Number! set GTN.AImsg=Less^^! && goto TheGame

:YouWon
cls
echo You won^^!
echo You had !GTN.Tries! until you found the correct one^^!
echo And the number was !GTN.Number!.
pause >nul
goto menu

:: Things I wrote when we talked about defenitions on cameras.
:: 2160p == 4K
:: 1440p == HD
:: 1080p == HD
:: 720p  == HD
:: 480p  == SD
:: 360p  == SD
:: 240p  == SD
:: 144p  == LD