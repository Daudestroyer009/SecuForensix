@echo off
setlocal

REM Define the output directory
set "OUTPUT_DIR=C:\Users\cyberfascinate\Desktop\TOOL"

REM Create the output directory if it doesn't exist
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

REM Define critical files and directories to monitor
set "CRITICAL_FILES=C:\Windows\System32\cmd.exe C:\Windows\System32\notepad.exe"
set "CRITICAL_DIRECTORIES=C:\Windows\System32\config"

REM Specify the location to store baseline integrity data
set "BASELINE_FILE=%OUTPUT_DIR%\baseline.txt"

REM Specify the location to store logs
set "LOG_FILE=%OUTPUT_DIR%\log.txt"

REM Function to calculate checksum of a file
:calculateChecksum
certutil -hashfile "%~1" SHA256 | findstr /r "[0-9a-f]*$" | findstr /v "^$"
exit /b

REM Function to compare checksums and detect changes
:monitorFiles
for %%F in (%CRITICAL_FILES%) do (
    call :calculateChecksum "%%F" > temp_current_checksum.txt
    findstr /v /c:"---" temp_current_checksum.txt > temp_current_checksum_cleaned.txt
    set /p CURRENT_CHECKSUM=<temp_current_checksum_cleaned.txt
    del /q temp_current_checksum*.txt

    findstr /i "%%F" "%BASELINE_FILE%" > temp_baseline_checksum.txt
    findstr /v /c:"---" temp_baseline_checksum.txt > temp_baseline_checksum_cleaned.txt
    set /p BASELINE_CHECKSUM=<temp_baseline_checksum_cleaned.txt
    del /q temp_baseline_checksum*.txt

    if not "%CURRENT_CHECKSUM%"=="%BASELINE_CHECKSUM%" (
        echo %DATE% %TIME% - File "%~nxF" has been modified or tampered with! >> "%LOG_FILE%"
        REM Add actions to take upon detection of unauthorized changes
    ) else (
        echo %DATE% %TIME% - File "%~nxF" is unchanged. >> "%LOG_FILE%"
    )
)

REM Additional logic for monitoring directories and other features can be added similarly

exit /b

REM Main execution starts here
if not exist "%BASELINE_FILE%" (
    echo Creating baseline integrity data...
    (
        REM Generate baseline integrity data for files
        for %%F in (%CRITICAL_FILES%) do (
            echo Checking file: %%F
            call :calculateChecksum "%%F"
            echo --- %%F: %ERRORLEVEL% ---
        )

        REM Generate baseline integrity data for directories
        REM (Note: This part can be more complex and might require additional scripting)
        REM Example: Use 'dir /s /b' command to list all files in directories and calculate checksums
    ) > "%BASELINE_FILE%"
) else (
    echo Baseline integrity data already exists.
)

echo %DATE% %TIME% - Monitoring critical files... >> "%LOG_FILE%"
call :monitorFiles

endlocal
