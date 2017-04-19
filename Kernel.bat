@echo off
title Text OS
setlocal enabledelayedexpansion
cd Data

set TextOS.realusername=!username!

if not exist Users (
 mkdir Users
 cd Users
 mkdir Shared
 mkdir !username!
 cd !username! && echo This is an example file >> Example.txt && cd..
) else (
 cd Users
 if not exist !username! (
  if exist !username!.redirect (
   < !TextOS.realusername!.redirect (
   set /p username=
   )
   if not exist !username! mkdir !username!
  ) else (
  mkdir !username!
  )
 )
 if not exist Shared mkdir Shared
 cd..
)
if exist tmp del /q tmp

:: Want to see all the TextOS-Specefic commands? do "set TextOS" in the devprompt
set TextOS.Version=0.1.066
set TextOS.StandardTitle=Text OS ^| Version: !TextOS.Version!
set TextOS.BootedFromTextOS=1
set TextOS.RandomNumber=%random%
if not defined TextOS.DevMode set TextOS.DevMode=0
set TextOS.UseBooterMsg=Make sure you boot from the booter.
set TextOS.SkipLoad=false
cd..
set TextOS.KernelFolder=%cd%
cd data
set TextOS.HomeFolder=%cd%\Users\!username!
set TextOS.DataFolder=%cd%
if exist installer set TextOS.Installer=true else set TextOS.Installer=false

if defined TextOS_SDK.FinalDebug goto FinalDebug

:: Version
!Download! http://text-os.github.io/fetch/version latestver
< latestver (
 set/p fetchedver=
)
del latestver
if !fetchedver! NEQ !TextOS.Version! set TextOS.Message=A new update is out. (!fetchedver!)


:: Errors
if not defined BIOS_ram call error_reporter.bat "Error loading RAM. !TextOS.UseBooterMsg!" "if not defined BIOS_ram"
if not defined BIOS_version call error_reporter.bat "Error loading BIOS version. !TextOS.UseBooterMsg!" "if not defined BIOS_version"
if !BIOSSETUP! NEQ exit call error_reporter.bat "^^!BIOSSETUP^^! is corrupted. !TextOS.UseBooterMsg!" "if !BIOSSETUP! NEQ exit"

if not defined TextOS.BootedFromTextOS call error_reporter.bat "Error loading TextOS.BootedFromTextOS." "if not defined TextOS.BootedFromTextOS"

if not defined Selection set TextOS.VarNotFound=^^!Selection^^! && goto Varcheck
if not defined Download set TextOS.VarNotFound=^^!Downloadt^^! && goto Varcheck
if not defined Timeout set TextOS.VarNotFound=^^!Timeout^^! && goto Varcheck
if not defined Oneup set TextOS.VarNotFound=^^!Oneup^^! && goto Varcheck
if not defined CLR set TextOS.VarNotFound=^^!CLR^^! && goto Varcheck

:Varcheck
if defined TextOS.VarNotFound call error_reporter.bat "The variable !TextOS.VarNotFound! is not defined. !UseBooterMsg!" "if !BIOSSETUP! NEQ exit"


:Password
if exist Users/!username!/pass (
	< Users/!username!/pass (
		set /p pass=
	)
	echo This account has a password.
	echo Please enter your password.
	set /p input_pass=^> 
	if !pass! NEQ !input_pass! (
		echo Wrong password.
		echo.
		echo Press any key to retry. . .
		pause >nul
		goto Password
	)
)

title !TextOS.StandardTitle!
if !TextOS.SkipLoad! == true goto menu
:Load
cls
echo Loading... 
!Timeout! 2

:menu
:: the variable !username! uses your account name, for example, for me the variable is Rasmusolle because my windows acc name is Rasmusolle.
cls
if defined TextOS.Message (
 echo !TextOS.Message!
 echo To update, type in "update" in the command prompt.
 echo.
)
echo ===============TEXT=OS=MENU==============
echo.
echo Hello !username!. Welcome to the Text-OS menu.
echo You are running Text-OS !TextOS.Version!
echo.
!Selection! "Command Prompt" "Programs" "Games" "Settings" "Exit"

if %errorlevel% == 1 goto precmd
if %errorlevel% == 2 goto Programs
if %errorlevel% == 3 goto Games
if %errorlevel% == 4 goto Settings_Main
if %errorlevel% == 5 exit
goto menu

:: ====================Programs====================

:Programs
cls
echo ===============PROGRAMS==============
echo.
!Selection! "Calculator" "Text-OS Browser" "Zombo.com Text Edition" "Back To Menu"

if %errorlevel% == 1 goto Calc
if %errorlevel% == 2 goto Browser
if %errorlevel% == 3 goto ZomboCom
if %errorlevel% == 4 goto menu
call :WrongErrorlevel
goto Programs

:Calc
cls
cd Programs
cd Calculator
set TextOS.FileToExecute=Calculator.bat
if not exist !TextOS.FileToExecute! goto NotFound
call !TextOS.FileToExecute!
title !TextOS.Standardtitle!
cd.. && cd..
goto menu

:Browser
cls
cd Programs
cd Browser
set TextOS.FileToExecute=Browser_Start.bat
if not exist !TextOS.FileToExecute! goto NotFound
call !TextOS.FileToExecute!
title !TextOS.Standardtitle!
cd.. && cd..
goto menu

:ZomboCom
cls
cd Programs
cd Zombocom_Text_Edition
set TextOS.FileToExecute=Start.bat
if not exist !TextOS.FileToExecute! goto NotFound
call !TextOS.FileToExecute!
title !TextOS.Standardtitle!
cd.. && cd..
goto menu

:: ====================Programs=End===================


:: ====================Games===================

:Games
cls
echo ===============GAMES===============
echo.
!Selection! "Guess The Number" "Back To Menu"

if %errorlevel% == 1 goto GuessTheNumber
if %errorlevel% == 2 goto menu
call :WrongErrorlevel
goto Games

:GuessTheNumber
cls
cd Games
cd GuessTheNumber
set TextOS.FileToExecute=GuessTheNumber.bat
if not exist !TextOS.FileToExecute! goto NotFound
call !TextOS.FileToExecute!
title !TextOS.StandardTitle!
cd.. && cd..
goto menu

:: ====================Games End====================

:: Generic errors for games and programs

:NotFound
cls
echo File not found.
pause >nul
goto menu

:WrongErrorLevel
cls
echo Invalid selection.
pause >nul
goto menu

:: ====================Text=OS=Command=Prompt====================

:precmd
cls
echo ====Text=OS=Command=Prompt====
echo.
echo Type help for a list of commands.
echo.
:cmd
set/p TextOS.CmdPromptInput=^>

call Commands\!TextOS.CmdPromptInput!

goto cmd


:: ====================Text=OS=Command=Prompt=End===================


:: ====================Settings===================


:Settings_Main
cls
echo ===SETTINGS===
echo.
!Selection! "Change username (Restart required)" "Wipe saved colorcode" "Password" "" "Back"

if %errorlevel% == 1 goto Change_Username
if %errorlevel% == 2 goto Wipe_Saved_Colorcode
if %errorlevel% == 3 goto Password_Main
if %errorlevel% == 4 goto Settings_Main
if %errorlevel% == 5 goto menu
goto Settings_Main


:Change_Username
cls
cd !TextOS.DataFolder! && cd Users
set/p TextOS.CU_changeto=Enter username to change to: 
if exist !TextOS.realusername!.redirect del !TextOS.realusername!.redirect
echo !TextOS.CU_changeto!>> !TextOS.realusername!.redirect
ren !username! !TextOS.CU_changeto!
cd !TextOS.DataFolder!
goto Settings_Main


:Password_Main
cls
echo ===PASSWORD=SETTINGS==
echo.

if not exist Users/!username!/pass (
	!Selection! "Create Password" "Remove Password" "Back"
) else (
	!Selection! "Change Password" "Remove Password" "Back"
)
if %errorlevel% == 1 goto Password_check
if %errorlevel% == 2 goto Password_Delete
if %errorlevel% == 3 goto Settings_Main


:Password_check
if not exist Users/!username!/pass (
	goto Password_Create
) else (
	goto Password_Change
)

:Password_Create
cls
echo Enter the password you want to use.
echo.
set /p input=^> 
echo.
echo Please type the password again.
echo.
set /p input2=^> 
if !input! == !input2! (
	cd !TextOS.DataFolder!
	cd Users/!username!
	echo !input!>>pass
) else (
	echo -------------------------
	echo Passwords doesn't match.
	echo.
	echo Press any key to retry. . .
	pause >nul
)
cd !TextOS.DataFolder!
goto Password_Main

:Password_Change
cls
cd !TextOS.DataFolder!
cd Users/!username!
< pass (
	set /p pass=
)
echo Enter the current password.
echo.
set /p input=^> 
if !input! == !pass! (
	del pass
	echo Enter the new password.
	echo.
	set/p input=^> 
	echo !input!>>pass
) else (
	echo That isn't the right password.
	echo Press any key to go back. . .
	pause >nul
)
cd !TextOS.DataFolder!
goto Password_Main

:Password_Delete
cls
cd !TextOS.DataFolder!
cd Users/!username!
< pass (
	set /p pass=
)
echo Enter the current password.
echo.
set /p input=^> 
if !input! == !pass! (
	del pass
	echo Your account's password has been removed.
	echo Press any key to go back. . .
	pause >nul
) else (
	echo That isn't the right password.
	echo Press any key to go back. . .
	pause >nul
)
cd !TextOS.DataFolder!
goto Password_Main


:Wipe_Saved_Colorcode
cls
if not exist colorcode.dat echo No colorcode found. && pause >nul && goto menu
:: else if it exists, confirm to delete it
echo This will delete the saved colorcode, are you sure?
echo.
!Selection! "Yes" "No"
if %errorlevel% == 1 (
 del colorcode.dat
 goto Settings_Main
)
if %errorlevel% == 2 goto Settings_Main
goto Settings_Main


:: ====================Settings End===================


:HomeDirectory
cls
echo This is coming soon.
pause >nul
goto menu

:FinalDebug
cls
echo ^^!--DEBUG--^^!
echo.
echo Do you want to do a FinalDebug Test?
!Selection! "Yes" "No"
if %errorlevel% == 1 goto FinalDebug_Start
if %errorlevel% == 2 exit

:FinalDebug_Start
cls
if defined TextOS_SDK.FileToDebug (
 call !TextOS_SDK.FileToDebug!
)
set/p TextOS.AppDebugger_Input=Enter File to debug (WITHOUT FILE EXTENSION): 
call !TextOS.AppDebugger_Input!.bat
exit

:DevPromptStart
cls
echo Type info for info
:DevPrompt
set/p c=%cd%^>
if !c! == info goto DevInfo
%c%
goto DevPrompt

:DevInfo
echo      This is a tool for developers to execute code through a prompt or to check variables.
echo      To go back to TextOS, type goto menu
goto DevPrompt





