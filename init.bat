@echo off
REM Author: Reece Higgins
rem init.bat, sets up our work environment including doskeys and updating env variables
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem jconsole is set at the end of this file and indicates it has been ran once already in the current env
if "%env_jconsole%" EQU "true" set "env_reload=true"

rem the current volume (the volume this file was started from
set env_volume=%~d0
set env_devvolume=z:

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
setlocal
set "folder_path=%env_volume%\deskX"
IF NOT EXIST "%folder_path%" (
    mkdir "%folder_path%"
    echo Desk Folder Created.
) else (
    echo Desk Folder exists.
)
echo Desk Folder set to %folder_path%

if not exist x:\ (
  subst x: %folder_path%
)
endlocal
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Only run the section below once, ignore for reloads
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
if "%env_reload%" EQU "true" goto endRunGaurd
:beginRunGaurd
set env_runonce=true

set path=%path%;^
%ProgramFiles%\Everything;^
%ProgramFiles%\Sublime Text;^
%env_devvolume%\Ruby32-x64\bin;^
%env_devvolume%\msys64\usr\bin

echo Welcome!
:endRunGaurd
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
REM Macros (doskey) File and Setup
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set dfile=j:\dkey.txt
doskey dkey=%dfile%
doskey dreload=doskey /macrofile=%dfile% $T doskey /macros:all

doskey /macrofile=dkey.txt
echo Doskey Loaded. Run `dkey` to edit, `dlist` to view

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem CoLoRs
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
for /F %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"

echo.
set envc_black=%ESC%[90m & set envc_red=%ESC%[91m & set envc_green=%ESC%[92m
set envc_yellow=%ESC%[93m & set envc_blue=%ESC%[94m & set envc_purple=%ESC%[95m
set envc_cyan=%ESC%[96m & set envc__d=%ESC%[0m
rem ensure that the default color `esc[0m` stays last alphabetically

rem Shorthand names
set "cxblk=%envc_blk%" & set "cxred=%envc_red%" & set "cxgrn=%envc_green%"
set "cxyel=%envc_yellow%" & set "cxblu=%envc_blue%" & set "cxprp=%envc_purple%"
set "cxcyn=%envc_cyan%"
set cxzz=%ESC%[0m
rem unset escape:
set "esc="

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
REM Set the Terminal Prompt
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set prompt=%envc_black%$P$_^
  %envc_green%$+$n:%envc_blue%$g%envc__d%

::jconsole and reload are variables to help our run once function
set "env_jconsole=true" & set "env_reload="
exit /B %errorlevel%
