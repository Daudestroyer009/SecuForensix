@echo off
title Advanced Registry Analysis and Malware Scan Tool
cls

echo Advanced Registry Analysis and Malware Scan Tool
echo ----------------------------------------------
echo Performing in-depth analysis of Windows registry hives...
echo.

set "outputFolder=%userprofile%\Desktop\Registry_Analysis_Results"
if not exist "%outputFolder%" mkdir "%outputFolder%"

set "logFile=%outputFolder%\Analysis_Log.txt"
echo [%date% %time%] Starting registry analysis... > "%logFile%"

rem Function to perform recursive registry analysis and save results to a text file
:analyzeRegistryRecursive
set "key=%1"
set "outputFile=%outputFolder%\%key%.txt"
reg query "%key%" > "%outputFile%" 2>nul
if %errorlevel% neq 0 (
    echo [%date% %time%] Unable to access registry key: %key%. Skipping analysis. >> "%logFile%"
    goto :eof
)

echo [%date% %time%] Analyzing registry key: %key%... >> "%logFile%"
echo [%date% %time%] Analyzing subkeys recursively... >> "%logFile%"
for /f "tokens=*" %%a in ('reg query "%key%" ^| findstr /r /c:"\(Default\)$"') do (
    call :analyzeRegistryRecursive "%key%\%%a"
)

findstr /I /C:"malware" /C:"trojan" /C:"virus" "%outputFile%" > nul && (
    echo [!] Suspicious entries found in: %key% >> "%logFile%"
    type "%outputFile%" >> "%outputFolder%\Suspicious_Entries.txt"
)

findstr /I /C:"Run" /C:"RunOnce" /C:"RunServices" /C:"RunServicesOnce" /C:"RunOnceEx" /C:"RunOnce\Setup" /C:"Startup" /C:"Explorer\Shell Folders" "%outputFile%" > nul && (
    echo [!] Potential malware persistence mechanisms found in: %key% >> "%logFile%"
    type "%outputFile%" >> "%outputFolder%\Malware_Persistence_Mechanisms.txt"
)

echo [%date% %time%] Registry key analysis completed: %key% >> "%logFile%"
goto :eof

rem Function to perform malware scan using an external antivirus tool
:performMalwareScan
set "scanPath=%1"
set "scanResultFile=%outputFolder%\Malware_Scan_Results.txt"
echo [%date% %time%] Performing malware scan using external antivirus tool... >> "%logFile%"
echo Scanning %scanPath%... Please wait...
"C:\Path\to\Your\Antivirus\Tool.exe" /scan %scanPath% > "%scanResultFile%"
echo [%date% %time%] Malware scan completed. Results saved to: %scanResultFile% >> "%logFile%"
goto :eof

rem Analyze various registry hives
call :analyzeRegistryRecursive "HKLM\Software"
call :analyzeRegistryRecursive "HKCU\Software"
call :analyzeRegistryRecursive "HKLM\System\CurrentControlSet\Control\Session Manager\Environment"
call :analyzeRegistryRecursive "HKCU\Control Panel\Desktop"
call :analyzeRegistryRecursive "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU"
call :analyzeRegistryRecursive "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs"

echo.
echo [+] Registry analysis complete. Results saved to: %outputFolder%
echo.

rem Perform malware scan on system drive (C:), change path as needed
call :performMalwareScan "C:\"

echo [+] Malware scan complete. Results saved to: %outputFolder%
echo.

echo [+] Analysis and scan complete. Check results in: %outputFolder%
echo.

pause
