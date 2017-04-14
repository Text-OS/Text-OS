::Booter for Text OS, used to read the kernel.bat and other files.
@echo off
title Text OS Booter
setlocal enabledelayedexpansion

::Sets the working directory to where the script is.
cd /d %~dp0

if exist devpls.txt set TextOS.DevMode=1

cls
echo Text OS booter loading...
ping localhost -n 2 >nul
cd Data

if exist out.txt del out.txt

if not exist cmdmenusel.exe goto cmdmenuselNOTFOUND

::Setting up custom commands
set Selection=cmdmenusel f870
set Timeout=ping localhost -n >nul
set CLR=color
set Oneup=cd..
set download=cscript /nologo %cd%\download.js

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

:: I think it's quite stupid not only the 
:: screen but that it's required. I think 
:: we'll remove this along with the 
:: requirements               /Rasmusolle
:BIOS
cls
:: Memory allocated is just there to be fancy :)
echo =======================================
echo Text OS BIOS !BIOS_version!
echo Allocated memory to Text OS: !BIOS_ram!
if defined NUMBER_OF_PROCESSORS echo Amount of processors: !NUMBER_OF_PROCESSORS!
echo =======================================
echo.
echo Press any key to exit to the booter...
pause >nul
goto menu

:: This one calls the kernel to be executed with the API strings and stuff.
:Boot
cls
!Oneup!
echo Reading Kernel.bat
!timeout! 3
cls
call Kernel.bat
