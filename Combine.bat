@echo off
cls
color 0A
echo Please select an option:
echo 1. Windows
echo 2. Android
echo 3. File Metadata Extraction
echo 4. File Integrity Monitoring
echo 5. Registry Analysis
echo 6. Timeline Analysis
echo 7. All Run
echo 8. Exit
echo.
set /p choice=Enter your choice (1-8): 

rem Check user's choice and execute the corresponding action
if "%choice%"=="1" (
    start Windows.bat
    pause
    goto main_menu
) else if "%choice%"=="2" (
    start Android.bat
    pause
    goto main_menu
) else if "%choice%"=="3" (
    start File_Metadata_Extraction.bat
    pause
    goto main_menu
) else if "%choice%"=="4" (
    start File_Integrity_Monitoring.bat
    pause
    goto main_menu
) else if "%choice%"=="5" (
    start Registry_Analysis.bat
    pause
    goto main_menu
) else if "%choice%"=="6" (
    start Timeline_Analysis.bat
    pause
    goto main_menu
) else if "%choice%"=="7" (
    start Windows.bat
    start Android.bat
    start File_Metadata_Extraction.bat
    start File_Integrity_Monitoring.bat
    start Registry_Analysis.bat
    start Timeline_Analysis.bat 
    pause
    goto main_menu
) else if "%choice%"=="8" (
    exit
) else (
    echo Invalid choice. Please enter either 1-8.
    pause
    goto main_menu
)
