@echo off
title Text-OS Browser Launcher
setlocal enabledelayedexpansion

set term=vt100
set home=%cd%\
set temp=%cd%\temp\
set lynx_cfg=%cd%\settings.ini
%cd%\lynx.exe %1 %2 %3 %4 %5

exit /b