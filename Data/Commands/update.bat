if not exist tmp (
	mkdir tmp
)
cd tmp

!Download! http://text-os.github.io/fetch/version vertmp
< vertmp (
 set/p fetchedver=
)

if !fetchedver! == !TextOS.Version! (
	echo Text-OS is up-to-date.
) else (
	echo Downloading latest version...

	if exist Text-OS_Setup_!fetchedver!.exe del Text-OS_Setup_!fetchedver!.exe
	if exist vertmp del vertmp
	
	!Download! https://github.com/Text-OS/Text-OS/releases/download/v!fetchedver!/Text-OS_Setup_!fetchedver!.exe Text-OS_Setup_!fetchedver!.exe
	start Text-OS_Setup_!fetchedver!.exe
	echo Please close down Text-OS when updating.
)
cd !TextOS.DataFolder!