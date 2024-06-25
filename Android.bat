@echo off
title Android Forensic Tool

REM Ask the user for the path to ADB executable
set /p ADB_PATH=Please enter the path to ADB executable (e.g., C:\path\to\adb.exe): 

REM Check if ADB executable exists
if not exist "%ADB_PATH%" (
    echo ADB executable not found. Please specify the correct path.
    pause
    exit /b
)

REM Connect to the device
echo Connecting to the device...
%ADB_PATH% devices
if errorlevel 1 (
    echo Failed to connect to the device. Ensure ADB is running and the device is connected.
    pause
    exit /b
)

REM Check if a device is connected
for /f "skip=1 tokens=1" %%i in ('%ADB_PATH% devices') do (
    if "%%i"=="device" (
        goto DeviceConnected
    )
)
echo No device connected. Please connect a device and try again.
pause
exit /b

:DeviceConnected
echo Device connected successfully.

REM Extract device information
echo.
echo Gathering device information...
%ADB_PATH% shell getprop > device_info.txt
if errorlevel 1 echo Failed to gather device information.

REM Run dumpstate to collect device state information
echo.
echo Running dumpstate to collect device state information...
%ADB_PATH% shell dumpstate > dumpstate.txt
if errorlevel 1 echo Failed to collect device state information.

REM Run logcat to collect system logs
echo.
echo Running logcat to collect system logs...
%ADB_PATH% logcat -d > logcat.txt
if errorlevel 1 echo Failed to collect system logs.

REM Gathering additional information...

REM Mount Points
echo.
echo Gathering mount points information...
%ADB_PATH% shell mount > mount_points.txt
if errorlevel 1 echo Failed to gather mount points information.

REM Network Connections
echo.
echo Gathering network connections information...
%ADB_PATH% shell netstat -p > network_connections.txt
if errorlevel 1 echo Failed to gather network connections information.

REM Date and Time information
echo.
echo Gathering date and time information...
%ADB_PATH% shell date > date_time_info.txt
if errorlevel 1 echo Failed to gather date and time information.

REM Storage Device Usage
echo.
echo Gathering storage device usage information...
%ADB_PATH% shell df > storage_device_usage.txt
if errorlevel 1 echo Failed to gather storage device usage information.

REM List of Open Files
echo.
echo Gathering list of open files...
%ADB_PATH% shell lsof > open_files_list.txt
if errorlevel 1 echo Failed to gather list of open files.

REM Amount of time the device has been running
echo.
echo Gathering device uptime information...
%ADB_PATH% shell uptime > device_uptime.txt
if errorlevel 1 echo Failed to gather device uptime information.

REM Ensure directories exist
if not exist "%cd%\Download" mkdir "%cd%\Download"
if not exist "%cd%\Pictures" mkdir "%cd%\Pictures"
if not exist "%cd%\DCIM" mkdir "%cd%\DCIM"

REM Pull important directories
echo.
echo Pulling important directories from the device...
%ADB_PATH% pull /sdcard/Download/ %cd%\Download
if errorlevel 1 echo Failed to pull /sdcard/Download directory.
%ADB_PATH% pull /sdcard/Pictures/ %cd%\Pictures
if errorlevel 1 echo Failed to pull /sdcard/Pictures directory.
%ADB_PATH% pull /sdcard/DCIM/ %cd%\DCIM
if errorlevel 1 echo Failed to pull /sdcard/DCIM directory.

echo.
echo Extraction complete. Press any key to exit.
pause >nul
