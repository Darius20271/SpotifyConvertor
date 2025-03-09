@echo off
setlocal enabledelayedexpansion

set /p download_path="Enter the download location: "

if not exist songs.txt (
    echo Songs.txt NOT FOUND!
    pause
    exit /b
)

for /f "tokens=*" %%a in (songs.txt) do (
    echo Finding: %%a
    yt-dlp -o "%download_path%\%%(title)s.%%(ext)s" "ytsearch:%%a"
)

echo Download Finished
pause
