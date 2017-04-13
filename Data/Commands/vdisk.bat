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
echo You are in VDisk mode.
echo.
call !TextOS.DataFolder!\Commands\VDisk\_main.bat