@echo off
setlocal enabledelayedexpansion enableextensions
set LIST=
set baseDir=.\sources
for %%x in (%baseDir%\*.swift) do set LIST=!LIST! %%x
set LIST=%LIST:~1%
endlocal & set SOURCEFILES=%LIST%