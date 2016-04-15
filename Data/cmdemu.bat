@echo off
cd C:\

:cmd
title %cd%
set/p i=%cd%^>
%i%
goto cmd
