;This is the installer for Text-OS, made with NSIS (MUI).
;The example script that this is based on this is written by Joost Verburg

;--------------------------------
;Define

  !define PRODUCT_NAME "Text-OS"
  !define PRODUCT_VERSION "0.1.062"
  !define PRODUCT_WEB_SITE "http://text-os.github.io"
  !define PRODUCT_UNINST_ROOT_KEY "HKLM"

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"
  XPStyle on

;--------------------------------
;General

  Name "Text OS ${PRODUCT_VERSION}"
  OutFile "Setup.exe"
  
  InstallDir "$PROGRAMFILES\Text-OS\"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\TEXT-OS" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel admin

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "LICENSE.txt"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  ;!insertmacro MUI_PAGE_FINISH
  
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  
;---------------------------------
;Intro Banner

Function .onInit
	Banner::show 

	Banner::getWindow
	Pop $1

	again:
		IntOp $0 $0 + 1
		Sleep 30
		StrCmp $0 100 0 again

	Banner::destroy
FunctionEnd

;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English" 

;--------------------------------
;Installer Sections

Section "Core" SecCore

  SectionIn RO

  SetOutPath "$INSTDIR"
  File Booter.bat
  File Kernel.bat
  File Changelog.txt
  
  SetOutPath "$INSTDIR\Data"
  CreateDirectory "$INSTDIR\Data\Downloads"
  CreateDirectory "$INSTDIR\Data\Games"
  CreateDirectory "$INSTDIR\Data\Programs"
  CreateDirectory "$INSTDIR\Data\VirtualDrives"
  File "Data\cmdmenusel.exe"
  
  ;Games folder
  SetOutPath "$INSTDIR\Data\Games"
  SetOutPath "$INSTDIR\Data\Games\GuessTheNumber"
  File "Data\Games\GuessTheNumber\GuessTheNumber.bat"
  File "Data\Games\GuessTheNumber\cmdmenusel.exe"
  
  ;Programs folder
  SetOutPath "$INSTDIR\Data\Programs"

  SetOutPath "$INSTDIR\Data\Programs\Calculator"
  File "Data\Programs\Calculator\Calculator.bat"
  File "Data\Programs\Calculator\cmdmenusel.exe"

  SetOutPath "$INSTDIR\Data\Programs\Browser"
  File "Data\Programs\Browser\Browser_Start.bat"
  File "Data\Programs\Browser\index.html"
  File "Data\Programs\Browser\lynx.exe"
  File "Data\Programs\Browser\settings.ini"
  CreateDirectory "$INSTDIR\Data\Programs\Browser\temp"
  SetOutPath "$INSTDIR\Data\Programs\Browser\temp"
  
  
  ;VirtualDrives folder
  SetOutPath "$INSTDIR\Data\VirtualDrives"
  SetOutPath "$INSTDIR\Data\VirtualDrives\A"
  File "Data\VirtualDrives\A\Grocery_List.doc"
  
  
  ;Start Menu Shortcuts
  CreateDirectory "$SMPROGRAMS\Text-OS\"
  CreateShortCut "$SMPROGRAMS\Text-OS\Start Text-OS.lnk" "$INSTDIR\Booter.bat"
  CreateShortCut "$SMPROGRAMS\Text-OS\Open Calculator (External).lnk" "$INSTDIR\Data\Calculator\Calculator.bat"
  CreateShortCut "$SMPROGRAMS\Text-OS\Uninstall Text-OS.lnk" "$INSTDIR\Uninstall.exe"
  
  ;Store installation folder
  WriteRegStr HKCU "Software\TEXT-OS" "" $INSTDIR
  
  ;Uninstaller work
  
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TEXT-OS\" "DisplayName" "Text-OS (Uninstall)"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TEXT-OS\" "UninstallString" "$INSTDIR\uninstall.exe"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TEXT-OS\" "NoModify" 1
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TEXT-OS\" "NoRepair" 1
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TEXT-OS\" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TEXT-OS\" "Publisher" "RasmusOlle"
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

Section "Extra stuff" SecXtra
  
  SetOutPath "$INSTDIR\Data\Downloads\"
  File "Data\Downloads\Fun.txt"
  
SectionEnd
  
;--------------------------------
;Descriptions


  LangString DESC_SecCore ${LANG_ENGLISH} "Core files (Required)"
  LangString DESC_SecXtra ${LANG_ENGLISH} "Extra stuff"
  
  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecCore} $(DESC_SecCore)
	!insertmacro MUI_DESCRIPTION_TEXT ${SecXtra} $(DESC_SecXtra)
	
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  RMDir /r "$INSTDIR\Data\"
  Delete "$INSTDIR\Booter.bat"
  Delete "$INSTDIR\Kernel.bat"
  Delete "$INSTDIR\Changelog.txt"
  
  RMDir /r "$SMPROGRAMS\Text-OS\"

  DeleteRegKey /ifempty HKCU "Software\TEXT-OS"
  DeleteRegKey /ifempty HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\TEXT-OS\"

SectionEnd