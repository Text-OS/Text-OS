:wiki
if exist USECHROME.txt set browser=Chrome.exe 
if exist USEFIREFOX.txt set browser=Firefox.exe
if not defined browser set browser=iexplore.exe
start !browser! !wiki_url!
exit /b