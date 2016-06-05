::=======================::
:: Guess The Number 1.02 ::
::    By RasmusOlle      ::
::=======================::
@echo off
title Guess The Number
setlocal enabledelayedexpansion

if not defined TextOS.BootedFromTextOS exit
set GTN.Version=1.02

title Guess The Number !GTN.Version!

:menu
cls
echo Guess The Number^^!
echo.
!Selection! "Start" "Changelog" "Exit to TextOS"

if %errorlevel% == 1 goto Intro
if %errorlevel% == 2 goto Changelog
if %errorlevel% == 3 exit /b
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
echo You had !GTN.Tries! tries until you found the correct one^^!
echo And the number was !GTN.Number!.
pause >nul
goto menu

:Changelog
cls
type changelog.txt
echo.
echo Press any key to go back.
pause >nul
goto menu