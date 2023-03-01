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
goto back

:back
cd ../../..
call installer.bat