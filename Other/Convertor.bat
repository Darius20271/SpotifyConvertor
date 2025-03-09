@echo off
setlocal enabledelayedexpansion

set /p input_dir="Enter the input directory (where .webm files are located): "
if not exist "%input_dir%" (
    echo ❌ Input Directory NOT FOUND: %input_dir%
    pause
    exit /b
)

set /p output_dir=<playlistName.txt
if not exist "%output_dir%" (
    mkdir "%output_dir%"
)

ffmpeg -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ ffmpeg NOT FOUND!
    pause
    exit /b
)

for %%F in ("%input_dir%\*.webm") do (
    set "input_file=%%F"
    set "output_file=%output_dir%\%%~nF.mp3"
    
    ffmpeg -i "!input_file!" -vn -ar 44100 -ac 2 -b:a 192k "!output_file!" -y
    
    if %errorlevel% neq 0 (
        echo ❌ ERROR: !input_file!
    ) else (
        echo ✅ DONE: !output_file!
    )
)

echo ACTION FINISHED
pause
