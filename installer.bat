@echo off
title Main Menu
rem "chcp 65001" allows to use non ASCII characters
chcp 65001
rem "cls" here clears output of chcp command that says its now using other character set
cls

rem Version variables
set "ver=pre-alpha 0.0.0.2"

rem Set "select" variable to "r" to make sure installer.bat doesnt crash when nothing is inputted on fresh boot
set "select=r"

rem Handler for downloading modules, if you making own version of this installer make git repo with your own /src folder and include your mods
:src-existance-checker
if exist "src" (
  rem Going to the "temp" folder handler
  goto temphandler
) else (
  rem Downloading "src" folder from project github, this folder includes modules for this to work (By going to src-handler)
  goto dl-src
)
cls

rem Handler for "temp" folder
:temphandler
if exist "src/temp" (
  rem Continuing with booting procedure
  cls
  goto clean
) else (
  rem Making "temp" directory in "src" folder
  cd src
  mkdir temp
  cd ..
)
cls

:clean
del /Q src\temp
cls
goto boot

rem Booting procedure and boot logo/art
:boot
echo  ____  ___  ___  ____    __    ____   ___  _   _  ____ 
echo (  _ \/ __)(__ )(  - \  /__\  (_  _) / __)( )_( )(_  _)
echo  )___/\__ \ (_ \ ) _ ^< /(  )\   )(  ( (__  ) _ (  _)(_  by KRWCLASSIC
echo (__)  (___/(___/(____/(__)(__) (__)  \___)(_) (_)(____) 
echo                 Version %ver%
echo.
echo.

rem P3M - PS3MAPI
rem P3B - PS3BATCHI

rem Selection procedure
echo 1) Check PS3MAPI connection.
echo 2) Send message to PS3.
echo 3) Other PS3MAPI features.
echo 4) Settings.
echo 5) Info.
echo.
set /p select="Option: "

if %select%==1 goto chk-p3m-con
if %select%==2 goto send-msg
if %select%==3 goto o-p3m-funcs
if %select%==4 goto settings
if %select%==5 goto info
rem Restart procedure
if %select%==r goto r

rem Selection executables
rem "exit" line between of each tag is to make sure installer.bat window is getting closed when opening other *.bat file

:chk-p3m-con
cd src/misc
call connection-check.bat
exit

:send-msg
cd src/misc/ps3mapi-func
call send-msg.bat
exit

:o-p3m-funcs
cd src/misc/ps3mapi-func
call p3m-menu.bat
exit

:settings
cd src/misc
call settings.bat
exit

:info
cd src/misc
call info.bat
exit

:dl-src
title Downloading PS3BATCHI (P3B) files...
mkdir temp & rem Installing 7-Zip and P3B from GitHub
cd temp
cls
echo Downloading embeded 7-Zip...
echo.
rem Downloading 7zip to unzip files from github
curl -LJOS https://github.com/KRWCLASSIC/PS3BACHI/raw/master/src/misc/7zEmbeded.exe
cls & rem Creating temp folder outside of the "src" folder (because it isnt exists yet) and downloading into it OME github repo
echo Downloading neccessary files...
echo.
rem Downloading entire repo
curl -LJO https://github.com/KRWCLASSIC/PS3BACHI/archive/master.zip
"7zEmbeded.exe" x -y PS3BACHI-master.zip
cls
cd .. & rem Moving out "src" folder out of the "temp" folder and removing unnecessary "temp" folder
move /y "temp/(Repo)/src" .
rd /s /q temp
cls & rem Restarting installer to make sure "src" folder is being detected, yes, you could just go back to the src-existance-checker but why? lol
goto r

rem Restart installer procedure
:r
call installer.bat
exit

rem Closing installer procedure
:exit
exit