@echo off

setlocal enabledelayedexpansion
set build_dir=build\windows

if not exist "%build_dir%" mkdir "%build_dir%"

if "%~1" == "release" (
	odin build tools/odinfmt/main.odin -file -show-timings -collection:src=src -out:odinfmt.exe -o:speed %2 %3 %4 %5 %6 %7 %8 %9
) else if "%~1" == "debug" (
	odin build tools/odinfmt/main.odin -file -show-timings  -collection:src=src -out:%build_dir%\odinfmt.exe -o:none -debug %2 %3 %4 %5 %6 %7 %8 %9
) else (
	odin build tools/odinfmt/main.odin -file -show-timings  -collection:src=src -out:%build_dir%\odinfmt.exe -o:speed %1 %2 %3 %4 %5 %6 %7 %8 %9
)
