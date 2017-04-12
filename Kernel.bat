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


:: Want to see all the TextOS-Specefic commands? do "set TextOS" in the devprompt
set TextOS.Version=0.1.067
set TextOS.StandardTitle=Text OS ^| Version: !TextOS.Version!
set TextOS.BootedFromTextOS=1
set TextOS.RandomNumber=%random%
if not defined TextOS.DevMode set TextOS.DevMode=0
set TextOS.UseBooterMsg=Make sure you boot from the booter.
set TextOS.MM=Error loading TextOS.BootedFromTextOS. Having this not set may crash Text-OS programs.
set TextOS.SkipLoad=false
set TextOS.Unrandomize=false
set TextOS.DoEchoOn=false
set TextOS.HomeFolder=%cd%\Users\!username!
set TextOS.DataFolder=%cd%
if exist installer set TextOS.Installer=true else set TextOS.Installer=false

if defined TextOS_SDK.FinalDebug goto FinalDebug

:: Version
cscript /nologo download.js http://text-os.github.io/fetch/version latestver
< latestver (
 set/p fetchedver=
)
del latestver
if !fetchedver! NEQ !TextOS.Version! set TextOS.Message=A new update is out. (!fetchedver!)


:: Errors
if not defined BIOS_ram (
                echo Error loading RAM. !TextOS.UseBooterMsg!
                echo For Booter developers, make sure your booter meets the requirements.
                pause >nul
                exit
                )

if not defined BIOS_version (
                echo Error loading BIOS version. !TextOS.UseBooterMsg!
                echo For Booter developers, make sure your booter meets the requirements.
                pause >nul
                exit
                )

if !BIOSSETUP! NEQ exit (
                echo ^^!BIOSSETUP^^! is corrupted. !TextOS.UseBooterMsg!
                echo For Booter developers, make sure your booter meets the requirements.
                pause >nul
                exit
                )

if not defined Selection set TextOS.VarNotFound=^^!Selection^^! && goto Varcheck
if not defined Timeout set TextOS.VarNotFound=^^!Timeout^^! && goto Varcheck
if not defined Oneup set TextOS.VarNotFound=^^!Oneup^^! && goto Varcheck
if not defined CLR set TextOS.VarNotFound=^^!CLR^^! && goto Varcheck

:Varcheck
if defined TextOS.VarNotFound (
                echo The variable !TextOS.VarNotFound! is not defined. !UseBooterMsg!
                echo For Booter developers, make sure your booter meets the requirements.
                pause >nul
                exit
                )

if not defined TextOS.BootedFromTextOS echo !TextOS.MM! && pause >nul && exit


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
!Timeout! 2 >nul

:menu
:: the variable !username! uses your account name, for example, for me the variable is Rasmusolle because my windows acc name is Rasmusolle.
cls
if defined TextOS.Message (
 echo !TextOS.Message!
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

if !TextOS.CmdPromptInput! == help goto help
if !TextOS.CmdPromptInput! == ver goto ver
if !TextOS.CmdPromptInput! == echo goto echo
if !TextOS.CmdPromptInput! == cls cls
if !TextOS.CmdPromptInput! == secret goto DevPromptStart
if !TextOS.CmdPromptInput! == color goto color
if !TextOS.CmdPromptInput! == "help color" goto helpcolor
if !TextOS.CmdPromptInput! == back color 07 && goto menu

if !TextOS.CmdPromptInput! == savecolor goto savecolor
if !TextOS.CmdPromptInput! == loadcolor goto loadcolor

if !TextOS.CmdPromptInput! == example echo This is a sample command.
if !TextOS.CmdPromptInput! == ping echo pong^^!
if !TextOS.CmdPromptInput! == wiki set wiki_url=https://github.com/Text-OS/Text-OS/wiki && call :wiki

if !TextOS.CmdPromptInput! == vdisk goto MountVirtualDisk
goto cmd

:help
echo.
echo This is a list of all commands.
echo.
echo ver - Shows TextOS and BIOS version.
echo echo - echo mode.
echo cls - Clears the screen.
echo color - Changes CMD color. Do helpcolor for colorcodes.
echo savecolor - Saves colorcode
echo loadcolor - Loads colorcode
echo wiki - Goes to the Text-OS wiki.
echo back - Goes back to the main menu.
echo vdisk - Virtual Disk.
goto cmd

:ver
echo Text OS version: !TextOS.Version!
echo BIOS version: !BIOS_version!
goto cmd

:echo
set /a echo_mode+=1
echo.
echo You are in echo mode.
set/p ECHO_INPUT=Enter: 
echo.
echo !ECHO_INPUT!
goto cmd

REM :loadprogram
REM echo.
REM echo You are in LoadProgram mode.
REM set/p TextOS.LoadProgramInput=Enter filename (put it in the "Data" folder, and exluding file extension):
REM echo.
REM if not exist !TextOS.LoadProgramInput!.bat echo Could not find the file. && !Timeout! 4 >nul && goto loadprogram
REM call !TextOS.LoadProgramInput!
REM goto menu

:: Copied from Command Prompt Wrapper.
:color
echo for help about the color code, do help code
set/p colorcode=type the color code:
color !colorcode!
goto cmd
:helpcolor
echo -----COLOR-----
echo Changes the background and text color.
echo List of colors:
echo.
echo 0  Black
echo 1  Blue
echo 2  Green
echo 3  Cyan
echo 4  Red
echo 5  Magenta
echo 6  Yellow
echo 7  White
echo 8  Gray/Grey
echo 9  Light Blue
echo A  Light Green
echo B  Light Cyan 
echo C  Light Red
echo D  Light Magenta
echo E  Light Yellow
echo F  Light White
echo.
echo The first color is the background, the second is the text.
echo The default color code is 07.
echo If no color code is given, then it will reset to the standard colors
goto cmd

:savecolor
cd !TextOS.DataFolder! && cd Users && cd !username!
if not defined colorcode (
 echo Colorcode not set.
 cd.. && cd..
 goto cmd
) else (
 if exist colorcode.dat del colorcode.dat
 echo !colorcode!>> colorcode.dat
 cd.. && cd..
 goto cmd
)

:loadcolor
cd !TextOS.DataFolder! && cd Users && cd !username!
if not exist colorcode.dat (
 echo Colorcode not found.
 cd.. && cd..
 goto cmd
) else (
 < colorcode.dat (
  set /p colorcode=
 )
 color !colorcode!
 cd.. && cd..
 goto cmd
)


:MountVirtualDisk
cd VirtualDrives
echo Enter letter: 
choice /c:abcdefghijklmnopqrstuvwxyz /n
if %errorlevel% == 1 set TextOS.MountedDrive=a
if %errorlevel% == 2 set TextOS.MountedDrive=b
if %errorlevel% == 3 set TextOS.MountedDrive=c
if %errorlevel% == 4 set TextOS.MountedDrive=d
if %errorlevel% == 5 set TextOS.MountedDrive=e
if %errorlevel% == 6 set TextOS.MountedDrive=f
if %errorlevel% == 7 set TextOS.MountedDrive=g
if %errorlevel% == 8 set TextOS.MountedDrive=h
if %errorlevel% == 9 set TextOS.MountedDrive=i
if %errorlevel% == 10 set TextOS.MountedDrive=j
if %errorlevel% == 11 set TextOS.MountedDrive=k
if %errorlevel% == 12 set TextOS.MountedDrive=l
if %errorlevel% == 13 set TextOS.MountedDrive=m
if %errorlevel% == 14 set TextOS.MountedDrive=n
if %errorlevel% == 15 set TextOS.MountedDrive=o
if %errorlevel% == 16 set TextOS.MountedDrive=p
if %errorlevel% == 17 set TextOS.MountedDrive=q
if %errorlevel% == 18 set TextOS.MountedDrive=r
if %errorlevel% == 19 set TextOS.MountedDrive=s
if %errorlevel% == 20 set TextOS.MountedDrive=t
if %errorlevel% == 21 set TextOS.MountedDrive=u
if %errorlevel% == 22 set TextOS.MountedDrive=v
if %errorlevel% == 23 set TextOS.MountedDrive=w
if %errorlevel% == 24 set TextOS.MountedDrive=x
if %errorlevel% == 25 set TextOS.MountedDrive=y
if %errorlevel% == 26 set TextOS.MountedDrive=z
if not exist !TextOS.MountedDrive! mkdir !TextOS.MountedDrive!
cd !TextOS.MountedDrive!
echo Mounted.
cls

:VDiskModeMsg
echo You are in VDisk mode.
echo.
:VDiskMode
set/p TextOS.VDiskModeInput=!TextOS.MountedDrive!:\
if !TextOS.VDiskModeInput! == back cd.. && cd.. && goto menu
if !TextOS.VDiskModeInput! == dir dir
if !TextOS.VDiskModeInput! == read goto VDisk_Read
if !TextOS.VDiskModeInput! == del goto VDisk_Del
if !TextOS.VDiskModeInput! == mkdir goto VDisk_Mkdir
if !TextOS.VDiskModeInput! == ren goto VDisk_Ren

if !TextOS.VDiskModeInput! == help goto VDisk_Help
if !TextOS.VDiskModeInput! == wiki set wiki_url=https://github.com/Text-OS/Text-OS/wiki/VDisk-Mode && call :wiki

if exist !TextOS.VDiskModeInput! "!TextOS.VDiskModeInput!"
goto VDiskMode

:VDisk_Read
set/p TextOS.VDisk_ReadInput=Enter file to read (with file extension): 
if not exist !TextOS.VDisk_ReadInput! call :VDisk_404 && goto VDisk_Read

type !TextOS.VDisk_ReadInput!
echo.
goto VDiskMode

:VDisk_Del
set/p TextOS.VDisk_DelInput=Enter file to delete (with file extension): 
if not exist !TextOS.VDisk_DelInput! call :VDisk_404 && goto VDisk_Del

del !TextOS.VDisk_DelInput!
echo Deleted !TextOS.VDisk_DelInput! successfully^^!
echo.
goto VDiskMode

:VDisk_Mkdir
set/p TextOS.VDisk_ReadInput=Enter name of directory: 

mkdir !TextOS.VDisk_ReadInput!
echo.
goto VDiskMode

:VDisk_Ren
set/p TextOS.VDisk_RenInput1=Enter filename of file to rename (with file extension): 
if not exist !TextOS.VDisk_RenInput1! call :VDisk_404 && goto VDisk_Ren

set/p TextOS.VDisk_RenInput2=Enter new name of file (with file extension): 

ren !TextOS.VDisk_RenInput1! !TextOS.VDisk_RenInput2!
goto VDiskMode

:VDisk_Help
echo.
echo This is a list of all commands:
echo.
echo back - goes back to the command prompt
echo dir - shows dir
echo read - reads a text file
echo del - deletes a file/directory
echo mkdir - makes a directory
echo ren - renames a file/directory
echo wiki - goes to the VDisk hub on the wiki
echo help - display this text
::echo.
::echo Please note that folder support is not fully implemented, but some buggy folder deleting stuff in del MAY work.
echo.
goto VDiskMode

:VDisk_404
echo Could not find file. Please try again.
pause >nul
exit /b

:: ====================Text=OS=Command=Prompt=End===================


:: ====================Settings===================


:Settings_Main
cls
echo ===SETTINGS===
echo.
!Selection! "Change username (Restart required)" "Wipe saved colorcode" "Passwords..." "" "Back"

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



:wiki
if exist USECHROME.txt set browser=Chrome.exe 
if exist USEFIREFOX.txt set browser=Firefox.exe
if not defined browser set browser=iexplore.exe
start !browser! !wiki_url!
exit /b


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





