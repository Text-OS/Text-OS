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
	echo Colorcode loaded.
	cd.. && cd..
)