cd !TextOS.DataFolder! && cd Users && cd !username!
if not defined colorcode (
	echo Colorcode not set.
	cd.. && cd..
) else (
	if exist colorcode.dat del colorcode.dat
	echo !colorcode!>> colorcode.dat
	echo Colorcode saved.
	cd.. && cd..
)