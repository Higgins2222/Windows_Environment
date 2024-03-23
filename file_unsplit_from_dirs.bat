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

rem Loop through each unique directory
for /d %%d in ("%source_dir%\*") do (
    rem Get the unique directory name
    set "unique_dir=%%d"
    
    rem Get the original file name
    set "original_file=!unique_dir!\game.iso"
    echo !original_file!
    
    rem Check if the original file exists
    if exist "!original_file!" (
        rem Copy the file back to its original location
        move "!original_file!" "!unique_dir:~2!.iso"
        
        rem Delete the unique directory
        rd /s /q "!unique_dir!"
    ) else (
        echo Original file not found for "!unique_dir!\game.iso". Skipping.
    )
)

echo All files restored to their original locations.
exit /b 0