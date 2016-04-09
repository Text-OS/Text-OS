::Booter for Text OS, used to read the kernel.bat and other files.
@echo off
title Text OS Booter
setlocal enabledelayedexpansion

if not exist cmdmenusel.exe goto cmdmenuselNOTFOUND

cls
echo Text OS booter loading...
ping localhost -n 2 >nul
cd Data

::Setting up custom commands
set Selection=cmdmenusel f870
set Timeout=ping localhost -n
set CLR=color
set Oneup=cd..

::Setting up BIOS
set BIOSSETUP=set
!BIOSSETUP! BIOS_version=0.1.015
!BIOSSETUP! BIOS_ram=5M
set BIOSSETUP=exit

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

:cmdmenuselNOTFOUND
if exist Data cd Data
echo Cmdmenusel.exe is not found^^!
echo Can you please go to http://bit.ly/22ibrQS, download it 
echo and put it in %cd%?
echo.
echo When you have done it, restart it.
pause >nul
exit

:: This one calls the kernel to be executed with the API strings and stuff.
:Boot
cls
!Oneup!
::echo Reading Kernel.dll...
echo Reading Kernel.bat
!timeout! 3 >nul
cls
call Kernel.bat
