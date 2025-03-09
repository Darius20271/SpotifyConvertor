@echo off
echo Installing required Python packages...

pip install spotipy
pip install requests
pip install yt-dlp

echo Python packages installed successfully.

echo Now, download the FFmpeg zip file from the following link:
echo https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl-shared.zip
start https://github.com/BtbN/FFmpeg-Builds/releases/download/latest/ffmpeg-master-latest-win64-gpl-shared.zip


echo Follow these steps to install FFmpeg:
echo 1. Unzip the downloaded file to a folder.
echo 2. Rename the folder to "ffmpeg".
echo 3. Move the "ffmpeg" folder to your C: drive (C:\).
echo 4. Open the "ffmpeg" folder and navigate to the "bin" folder (C:\ffmpeg\bin).
echo 5. Copy the path of the "bin" folder (C:\ffmpeg\bin).
echo 6. Press Win + X, then click "System".
echo 7. Click "Advanced system settings" and then "Environment Variables".
echo 8. Under "System variables", find and select the "Path" variable, then click "Edit".
echo 9. In the "Edit environment variable" window, click "New" and paste the copied path.
echo 10. Click "OK" to save your changes.
echo 11. Restart your computer to apply the changes.

pause
