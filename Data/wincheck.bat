:: Windows version checker for Text-OS made by RasmusOlle
::
:: Licensed under the MIT license (see license.txt)
@echo off
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if %version% == 10.0 set TextOS.WindowsVersion=Windows 10 && echo Windows 10
if %version% == 6.4 set TextOS.WindowsVersion=Windows 10 Beta && echo Windows 10 Beta
if %version% == 6.3 set TextOS.WindowsVersion=Windows 8.1 && echo Windows 8.1
if %version% == 6.2 set TextOS.WindowsVersion=Windows 8 && echo Windows 8
if %version% == 6.1 set TextOS.WindowsVersion=Windows 7 && echo Windows 7
if %version% == 6.0 set TextOS.WindowsVersion=Windows Vista && echo Windows Vista
if %version% == 5.5 set TextOS.WindowsVersion=Windows Neptune && echo Windows Neptune
if %version% == 5.2 set TextOS.WindowsVersion=Windows Server 2003 && echo Windows Server 2003
if %version% == 5.1 set TextOS.WindowsVersion=Windows XP && echo Windows XP
if %version% == 5.0 set TextOS.WindowsVersion=Windows 2000 && echo Windows 2000
exit/b