@echo off
title Download Test
cd ..

rem Making "test" folder and going into it
mkdir test
cd test
cls

rem Download test file from github with diffrent name
curl https://raw.githubusercontent.com/KRWCLASSIC/OpenModpackEngine/master/src/misc/test_download.txt -o test_downloadED.txt
echo.

rem Going back to the installer.bat and closing this script
echo Downloading done!
timeout /t 2 >nul
cd ../..
call installer.bat
exit