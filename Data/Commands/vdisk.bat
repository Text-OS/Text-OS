cd VirtualDrives
echo Enter letter: 
choice /c:abcdefghijklmnopqrstuvwxyz /n
if %errorlevel% == 1 set TextOS.MountedDrive=A
if %errorlevel% == 2 set TextOS.MountedDrive=B
if %errorlevel% == 3 set TextOS.MountedDrive=C
if %errorlevel% == 4 set TextOS.MountedDrive=D
if %errorlevel% == 5 set TextOS.MountedDrive=E
if %errorlevel% == 6 set TextOS.MountedDrive=F
if %errorlevel% == 7 set TextOS.MountedDrive=G
if %errorlevel% == 8 set TextOS.MountedDrive=H
if %errorlevel% == 9 set TextOS.MountedDrive=I
if %errorlevel% == 10 set TextOS.MountedDrive=J
if %errorlevel% == 11 set TextOS.MountedDrive=K
if %errorlevel% == 12 set TextOS.MountedDrive=L
if %errorlevel% == 13 set TextOS.MountedDrive=M
if %errorlevel% == 14 set TextOS.MountedDrive=N
if %errorlevel% == 15 set TextOS.MountedDrive=O
if %errorlevel% == 16 set TextOS.MountedDrive=P
if %errorlevel% == 17 set TextOS.MountedDrive=Q
if %errorlevel% == 18 set TextOS.MountedDrive=R
if %errorlevel% == 19 set TextOS.MountedDrive=S
if %errorlevel% == 20 set TextOS.MountedDrive=T
if %errorlevel% == 21 set TextOS.MountedDrive=U
if %errorlevel% == 22 set TextOS.MountedDrive=V
if %errorlevel% == 23 set TextOS.MountedDrive=W
if %errorlevel% == 24 set TextOS.MountedDrive=X
if %errorlevel% == 25 set TextOS.MountedDrive=Y
if %errorlevel% == 26 set TextOS.MountedDrive=Z
if not exist !TextOS.MountedDrive! mkdir !TextOS.MountedDrive!
cd !TextOS.MountedDrive!
echo Mounted.
cls
echo You are in VDisk mode.
echo.
call !TextOS.DataFolder!\Commands\VDisk\_main.bat