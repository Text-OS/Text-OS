@echo off
title Batch Calculator
setlocal enabledelayedexpansion

REM Check if its running from TextOS or not.
if not defined TextOS.BootedFromTextOS set Selection=cmdmenusel f870

set Calculator_Version=0.5.1

:main
cls
echo Batch Calculator^^!
echo.
!Selection! "Addition" "Subtraction" "Multiplication" "Exit"

if %errorlevel% == 1 set Counting=+
if %errorlevel% == 2 set Counting=-
if %errorlevel% == 3 set Counting=*
if %errorlevel% == 4 exit /b

cls
set/p 1n=Enter First number: 
echo.
set/p 2n=Enter Second number: 

set /a answer=!1n!!Counting!!2n!
cls
echo The Answer Is: !answer!^^!
pause >nul

goto main