::Booter for Text OS, used to read the kernel.dll and other files.
@echo off
title Text OS Booter
setlocal enabledelayedexpansion

echo Text OS booter loading...
ping localhost -n 2 >nul
cd Data

set TextOS_Booter.APIstrings=4

::Setting up custom commands
set BIOSSETUP=set
set Selection=cmdmenusel f870
set Timeout=ping localhost -n
set CLR=color
set Oneup=cd..

::Setting up BIOS
!BIOSSETUP! BIOS_version=0.1.015
!BIOSSETUP! BIOS_ram=5M

:menu
cls
echo                       ============================
echo                       ^|      TEXT OS BOOTER      ^|
echo                       ============================
echo.
!Selection! "Boot" "BIOS"
if %errorlevel% == 1 goto Boot
if %errorlevel% == 2 goto BIOS
goto menu

:BIOS
cls
:: Memory allocated is just there to be fancy :)
echo =======================================
echo Text OS BIOS !BIOS_version!
echo Allocated memory to Text OS: !BIOS_ram!
echo =======================================
echo.
echo Press any key to exit to the booter...
pause >nul
goto menu

:: This one calls the kernel to be executed with the API strings and stuff.
:Boot
cls
!Oneup!
echo Reading Kernel.dll...
!timeout! 3 >nul
cls
call Kernel.bat