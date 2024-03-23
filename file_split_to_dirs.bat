@echo off
setlocal enabledelayedexpansion

rem Specify the source directory containing the files
if /i "%~1"=="" (
    echo "no source dir provided"
    exit /b 1
)
set "source_dir=%~1"

rem Check if the source directory exists
if not exist "%source_dir%" (
    echo Source directory does not exist.
    exit /b 1
)

rem Loop through each file in the source directory
for %%a in ("%source_dir%\*.*") do (
    rem Create a unique directory name based on the file name
    set "file_name=%%~nxa"
    set "file_name=!file_name:.=!"
    set "destination_dir=%source_dir%\!file_name!"

    rem Create the unique directory
    mkdir "!destination_dir!"

    rem Copy the file into the unique directory with the name file.iso
    move "%%a" "!destination_dir!\game.iso"
)

echo All files copied into unique directories with name file.iso.
exit /b 0