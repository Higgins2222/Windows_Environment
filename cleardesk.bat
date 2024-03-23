@echo off
rem Clears the system desktop, by default removes only .lnk files
setlocal

rem Sets desktop path based on whether OneDrive is installed or not
if %OneDrive% NEQ "" (
  set "pc_desktop=%OneDrive%\Desktop"
) else (
  set "pc_desktop=%USERPROFILE%\Desktop"
)

rem Perform actions based on the selected option
if /i "%~1"=="/h" (
    echo Help:
    echo /all - clears all files except 'desktop.ini'
) else if /i "%~1"=="/all" (
    rem Delete all desktop files except for desktop.ini
    echo Clearing...
    for %%a in (%pc_desktop%\*) do (
      if /i not "%%~nxa"=="desktop.ini" (
        echo %%a
        del "%%a"
      )
    )
    echo ALL DESKTOP FILES CLEARED!
    rem Add your command for option 2 here
) else (
  rem delete all .lnk files
  for %%a in (%pc_desktop%\*.lnk) do del "%%a"
  echo Desktop Cleared. ^(only .lnk files^)
)

endlocal
exit /b 0