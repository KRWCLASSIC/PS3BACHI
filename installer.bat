@echo off
title Main Menu
rem "chcp 65001" allows to use non ASCII characters
chcp 65001
rem If you want to change filename you also need to change it here:
set "BasicBatchMenuFilename=installer.bat"
rem "cls" here clears output of chcp command that says its now using other character set
cls

rem Version variables
set "ver=x.x.x"

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
echo      ASCII
echo                        ART
echo                                        GOES
echo                                                         Here
echo                                                                          :D
echo                  Version %ver%                               by KRWCLASSIC
echo.
echo.

rem Selection procedure
echo 1) Option 1
echo 2) Option 2
echo 3) Option 3
echo 4) Option 4
echo 5) Option 5
echo.
set /p select="Option: "

if %select%==1 goto 1
if %select%==2 goto 2
if %select%==3 goto 3
if %select%==4 goto 4
if %select%==5 goto 5
rem Restart procedure
if %select%==r goto r

rem Selection executables
rem "exit" line between of each tag is to make sure installer.bat window is getting closed when opening other *.bat file

:1
cd src/somefolder
call somefile1.bat
exit

:2
cd src/somefolder
call somefile2.bat
exit

:3
cd src/somefolder
call somefile3.bat
exit

:4
cd src/somefolder
call somefile4.bat
exit

:5
cd src/somefolder
call somefile5.bat
exit

:dl-src
title Downloading (Your app name) files...
mkdir temp & rem Installing 7-Zip from GitHub
cd temp
cls
echo Downloading embeded 7-Zip...
echo.
rem Downloading 7zip to unzip files from github
rem If you dont want to add 7z to your files you can use this link: https://github.com/KRWCLASSIC/OpenModpackEngine/raw/master/src/misc/7zEmbeded.exe
curl -LJOS https://github.com/(RepoAuthor)/(Repo)/raw/master/src/(misc)/7zEmbeded.exe
cls & rem Creating temp folder outside of the "src" folder (because it isnt exists yet) and downloading into it OME github repo
echo Downloading neccessary files...
echo.
rem Downloading entire repo
curl -LJO https://github.com/(RepoAuthor)/(Repo)/archive/master.zip
"7zEmbeded.exe" x -y (Repo)-master.zip
cls
cd .. & rem Moving out "src" folder out of the "temp" folder and removing unnecessary "temp" folder
move /y "temp/(Repo)/src" .
rd /s /q temp
cls & rem Restarting installer to make sure "src" folder is being detected, yes, you could just go back to the src-existance-checker but why? lol
goto r

rem Restart installer procedure
:r
call %BasicBatchMenuFilename%
exit

rem Closing installer procedure
:exit
exit