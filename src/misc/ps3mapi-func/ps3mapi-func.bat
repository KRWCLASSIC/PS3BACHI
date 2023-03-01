@echo off
title Other PS3MAPI functions.
:start
cls

echo 1) Shutdown PS3.
echo 2) Add P3B Profile.
echo 3) Edit P3B Profile.
echo.
echo 0) Back
echo.
set "settings-select=0"
set /p settings-select="Option: "
if "%settings-select%"==" " goto back
if %settings-select%==0 goto back
if %settings-select%==1 goto sdown-ps3
if %settings-select%==2 goto a-p3b-p
if %settings-select%==3 goto e-p3b-p
goto back

:sdown-ps3
cls
curl http://192.168.%c-ip%/shutdown.ps3 >nul 2>&1
timeout 2 >nul
goto start

:a-p3b-p
cls
echo This isn't implemented yet!
timeout 2 >nul
goto start

:e-p3b-p
cls
echo This isn't implemented yet!
timeout 2 >nul
goto start

:back
cd ../..
cd
call installer.bat
exit