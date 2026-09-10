@echo off

setlocal enabledelayedexpansion
set build_dir=build\windows

if not exist "%build_dir%" mkdir "%build_dir%"

if "%1" == "debug" (
	odin build tools/odinfmt/main.odin -file -show-timings -collection:src=src -out:%build_dir%\odinfmt.exe -o:none
) else (
	odin build tools/odinfmt/main.odin -file -show-timings -collection:src=src -out:%build_dir%\odinfmt.exe -o:speed
)
