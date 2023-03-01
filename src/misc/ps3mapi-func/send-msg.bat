@echo off
title Message sender
cls

set /p c-ip="Console IP: 192.168."
cls

:msg

set msg=" "
set /p msg="Message: "

curl http://192.168.%c-ip%/notify.ps3mapi?msg=%msg% >nul 2>&1

:next
goto msg

:back
rem Moving created OMEmodule to "OMEmodules" folder and going back to main menu (installer.bat)
cd ../../../..
move /y "src\misc\tools\working-dir\%filename%.OMEmodule" "src\misc\OMEmodules\%filename%.OMEmodule" >nul
cls
echo "%filename%.OMEmodule" moved to "OMEmodules" folder!
timeout 6 >nul
call installer.bat