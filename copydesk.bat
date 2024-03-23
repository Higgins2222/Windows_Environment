@echo off
setlocal

if %OneDrive% NEQ "" (
  set "pc_desktop=%OneDrive%\Desktop"
) else (
  set "pc_desktop=%USERPROFILE%\Desktop"
)


copy j:\deskX\ %pc_desktop%

rem not needed, the above works just fine for now
rem for /F %%a in ("j:\deskX\") do copy %%a %pc_desktop%

endlocal
exit /b %errorlevel%