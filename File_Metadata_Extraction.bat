@echo off
setlocal enabledelayedexpansion

REM Parameterization: Prompt user for directory path and output file name
set /p directory=Enter the directory path containing the files: 
set /p output_file=Enter the output file name (including full path): 

REM Error Handling: Check if the directory exists
if not exist "%directory%" (
    echo Error: Directory "%directory%" does not exist.
    exit /b 1
)

REM Clear previous output file
del "%output_file%" 2>nul

REM Logging: Log script start time
echo Script start time: %date% %time% >> "%output_file%"

REM Loop through files in the directory
for %%F in ("%directory%\*.*") do (
    REM Extract metadata based on file type
    if /I "%%~xF"==".docx" (
        REM For DOCX files (Microsoft Word)
        echo Processing: %%~nxF >> "%output_file%"
        echo ===================== >> "%output_file%"
        for /f "tokens=*" %%A in ('powershell -command "& { (Get-Item '%%~fF').CreationTime; (Get-Item '%%~fF').LastWriteTime; (Get-Item '%%~fF').Length/1KB}"') do (
            echo %%A >> "%output_file%"
        )
        echo. >> "%output_file%"
    ) else if /I "%%~xF"==".md" (
        REM For MD files (Markdown)
        echo Processing: %%~nxF >> "%output_file%"
        echo ===================== >> "%output_file%"
        for /f "tokens=*" %%A in ('powershell -command "& { (Get-Item '%%~fF').CreationTime; (Get-Item '%%~fF').LastWriteTime; (Get-Item '%%~fF').Length/1KB}"') do (
            echo %%A >> "%output_file%"
        )
        echo. >> "%output_file%"
    ) else if /I "%%~xF"==".jpg" (
        REM For JPG files (images)
        echo Processing: %%~nxF >> "%output_file%"
        echo ===================== >> "%output_file%"
        for /f "tokens=*" %%A in ('powershell -command "& { (Get-Item '%%~fF').CreationTime; (Get-Item '%%~fF').LastWriteTime; (Get-Item '%%~fF').Length/1KB}"') do (
            echo %%A >> "%output_file%"
        )
        echo. >> "%output_file%"
    ) else if /I "%%~xF"==".pdf" (
        REM For PDF files
        echo Processing: %%~nxF >> "%output_file%"
        echo ===================== >> "%output_file%"
        for /f "tokens=*" %%A in ('powershell -command "& { $pdfInfo = (Get-Item '%%~fF' | Select-String 'CreationDate|ModDate|Pages|File size'); $pdfInfo -join '`n' }"') do (
            echo %%A >> "%output_file%"
        )
        echo. >> "%output_file%"
    ) else if /I "%%~xF"==".png" (
        REM For PNG files (images)
        echo Processing: %%~nxF >> "%output_file%"
        echo ===================== >> "%output_file%"
        for /f "tokens=*" %%A in ('powershell -command "& { (Get-Item '%%~fF').CreationTime; (Get-Item '%%~fF').LastWriteTime; (Get-Item '%%~fF').Length/1KB}"') do (
            echo %%A >> "%output_file%"
        )
        echo. >> "%output_file%"
    ) else if /I "%%~xF"==".xlsx" (
        REM For XLSX files (Microsoft Excel)
        echo Processing: %%~nxF >> "%output_file%"
        echo ===================== >> "%output_file%"
        for /f "tokens=*" %%A in ('powershell -command "& { (Get-Item '%%~fF').CreationTime; (Get-Item '%%~fF').LastWriteTime; (Get-Item '%%~fF').Length/1KB}"') do (
            echo %%A >> "%output_file%"
        )
        echo. >> "%output_file%"
    ) else if /I "%%~xF"==".mp4" (
        REM For MP4 video files
        echo Processing: %%~nxF >> "%output_file%"
        echo ===================== >> "%output_file%"
        for /f "tokens=*" %%A in ('powershell -command "& { $videoInfo = (Get-Item '%%~fF' | Select-Object -Property CreationTime, LastWriteTime, Length, Length); $videoInfo -join '`n' }"') do (
            echo %%A >> "%output_file%"
        )
        echo. >> "%output_file%"
    ) else if /I "%%~xF"==".mov" (
        REM For MOV video files
        echo Processing: %%~nxF >> "%output_file%"
        echo ===================== >> "%output_file%"
        for /f "tokens=*" %%A in ('powershell -command "& { $videoInfo = (Get-Item '%%~fF' | Select-Object -Property CreationTime, LastWriteTime, Length, Length); $videoInfo -join '`n' }"') do (
            echo %%A >> "%output_file%"
        )
        echo. >> "%output_file%"
    ) else if /I "%%~xF"==".avi" (
        REM For AVI video files
        echo Processing: %%~nxF >> "%output_file%"
        echo ===================== >> "%output_file%"
        for /f "tokens=*" %%A in ('powershell -command "& { $videoInfo = (Get-Item '%%~fF' | Select-Object -Property CreationTime, LastWriteTime, Length, Length); $videoInfo -join '`n' }"') do (
            echo %%A >> "%output_file%"
        )
        echo. >> "%output_file%"
    ) else if /I "%%~xF"==".mkv" (
        REM For MKV video files
        echo Processing: %%~nxF >> "%output_file%"
        echo ===================== >> "%output_file%"
        for /f "tokens=*" %%A in ('powershell -command "& { $videoInfo = (Get-Item '%%~fF' | Select-Object -Property CreationTime, LastWriteTime, Length, Length); $videoInfo -join '`n' }"') do (
            echo %%A >> "%output_file%"
        )
        echo. >> "%output_file%"
    ) else if /I "%%~xF"==".txt" (
        REM For TXT text files
        echo Processing: %%~nxF >> "%output_file%"
        echo ===================== >> "%output_file%"
        for /f "tokens=*" %%A in ('powershell -command "& { (Get-Item '%%~fF').CreationTime; (Get-Item '%%~fF').LastWriteTime; (Get-Item '%%~fF').Length/1KB}"') do (
            echo %%A >> "%output_file%"
        )
        echo. >> "%output_file%"
    ) else if /I "%%~xF"==".csv" (
        REM For CSV files
        echo Processing: %%~nxF >> "%output_file%"
        echo ===================== >> "%output_file%"
        for /f "tokens=*" %%A in ('powershell -command "& { (Get-Item '%%~fF').CreationTime; (Get-Item '%%~fF').LastWriteTime; (Get-Item '%%~fF').Length/1KB}"') do (
            echo %%A >> "%output_file%"
        )
        echo. >> "%output_file%"
    ) else (
        REM For unsupported file types
        echo Unsupported file type: %%~nxF >> "%output_file%"
        echo ===================== >> "%output_file%"
        echo Metadata extraction not supported for this file type. >> "%output_file%"
        echo. >> "%output_file%"
    )
)

REM Logging: Log script end time
echo Script end time: %date% %time% >> "%output_file%"

echo Metadata extraction completed. Output saved to: %output_file%
pause
