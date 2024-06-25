@echo off
title Highly Advanced Windows Forensic Tool

REM Creating output directory
set OUTPUT_DIR=%cd%\Forensic_Output
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

REM Gathering system information...

REM Collecting system information
echo Gathering system information...
systeminfo > "%OUTPUT_DIR%\system_info.txt"
echo System information saved to Forensic_Output\system_info.txt.

REM Running ipconfig to collect network information
echo.
echo Gathering network information...
ipconfig /all > "%OUTPUT_DIR%\network_info.txt"
echo Network information saved to Forensic_Output\network_info.txt.

REM Checking active network connections
echo.
echo Checking active network connections...
netstat -ano > "%OUTPUT_DIR%\active_connections.txt"
echo Active network connections saved to Forensic_Output\active_connections.txt.

REM Gathering date and time information
echo.
echo Gathering date and time information...
date /t > "%OUTPUT_DIR%\date_info.txt"
time /t >> "%OUTPUT_DIR%\date_info.txt"
echo Date and time information saved to Forensic_Output\date_info.txt.

REM Checking disk usage
echo.
echo Checking disk usage...
wmic logicaldisk get deviceid,description,size,freespace > "%OUTPUT_DIR%\disk_usage.txt"
echo Disk usage information saved to Forensic_Output\disk_usage.txt.

REM Checking running processes
echo.
echo Checking running processes...
tasklist > "%OUTPUT_DIR%\running_processes.txt"
echo List of running processes saved to Forensic_Output\running_processes.txt.

REM Gathering event logs
echo.
echo Gathering event logs...
wevtutil qe System /f:text /q:"*[System[(EventID=4624)]]" > "%OUTPUT_DIR%\successful_logons.txt"
wevtutil qe System /f:text /q:"*[System[(EventID=4634)]]" > "%OUTPUT_DIR%\logoffs.txt"
echo Successful logon events saved to Forensic_Output\successful_logons.txt and logoff events saved to Forensic_Output\logoffs.txt.

REM Extracting browser artifacts (Chrome)
echo.
echo Extracting Chrome browser artifacts...
copy "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\History" "%OUTPUT_DIR%\chrome_history"
copy "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Cookies" "%OUTPUT_DIR%\chrome_cookies"
echo Chrome browser artifacts copied to Forensic_Output directory.

REM Checking for suspicious files
echo.
echo Checking for suspicious files...
dir "C:\Windows\System32\*.exe" /s /b /a:-d > "%OUTPUT_DIR%\suspicious_files.txt"
echo Suspicious files list saved to Forensic_Output\suspicious_files.txt.

REM Capturing volatile memory (RAM)
echo.
echo Capturing volatile memory...
winpmem.exe -o "%OUTPUT_DIR%\memory_dump.raw"
echo Volatile memory (RAM) captured and saved to Forensic_Output\memory_dump.raw.

echo.
echo Extraction complete. Forensic data saved in Forensic_Output directory. Press any key to exit.
pause >nul