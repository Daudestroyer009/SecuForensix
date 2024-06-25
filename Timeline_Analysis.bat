@echo off
title Combined Timeline Analysis Tool

REM Set output directory
set OUTPUT_DIR=%~dp0Forensic_Output
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

REM Get current date and time
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
set year=%datetime:~0,4%
set month=%datetime:~4,2%
set day=%datetime:~6,2%
set hour=%datetime:~8,2%
set minute=%datetime:~10,2%
set second=%datetime:~12,2%

REM Create timeline file
set timelineFile=%OUTPUT_DIR%\Combined_Timeline_%year%-%month%-%day%_%hour%-%minute%-%second%.txt
echo Combined Timeline Analysis Tool>"%timelineFile%"
echo Generated on: %year%-%month%-%day% %hour%:%minute%:%second%>>"%timelineFile%"
echo.>>"%timelineFile%"

REM Get system events
echo System Events:>>"%timelineFile%"
echo -------------->>"%timelineFile%"
echo.>>"%timelineFile%"
echo === SYSTEM LOG ===>>"%timelineFile%"
wevtutil qe System /rd:true /c:10 /f:text>>"%timelineFile%"
echo.>>"%timelineFile%"
echo === APPLICATION LOG ===>>"%timelineFile%"
wevtutil qe Application /rd:true /c:10 /f:text>>"%timelineFile%"
echo.>>"%timelineFile%"
echo === SECURITY LOG ===>>"%timelineFile%"
wevtutil qe Security /rd:true /c:10 /f:text>>"%timelineFile%"
echo.>>"%timelineFile%"

REM Get user activities
echo User Activities:>>"%timelineFile%"
echo ---------------->>"%timelineFile%"
echo.>>"%timelineFile%"
echo === RECENT DOCUMENTS ===>>"%timelineFile%"
echo.>>"%timelineFile%"
dir /b /o:d /a:-d "%UserProfile%\Recent\*">>"%timelineFile%"
echo.>>"%timelineFile%"
echo === RECENT PROGRAMS ===>>"%timelineFile%"
echo.>>"%timelineFile%"
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist" /s | findstr /i "Count">>"%timelineFile%"
echo.>>"%timelineFile%"
echo === RECENTLY USED FILES ===>>"%timelineFile%"
echo.>>"%timelineFile%"
dir /b /o:d /a:-d "%UserProfile%\AppData\Roaming\Microsoft\Windows\Recent\*">>"%timelineFile%"
echo.>>"%timelineFile%"
echo === RECENTLY USED FOLDERS ===>>"%timelineFile%"
echo.>>"%timelineFile%"
dir /b /o:d /a:-d "%UserProfile%\AppData\Roaming\Microsoft\Windows\Recent\*">>"%timelineFile%"
echo.>>"%timelineFile%"

REM Get network connections
echo Network Connections:>>"%timelineFile%"
echo -------------------->>"%timelineFile%"
echo.>>"%timelineFile%"
netstat -ano>>"%timelineFile%"

echo Combined Timeline generated successfully. Output saved to "%timelineFile%"
pause
