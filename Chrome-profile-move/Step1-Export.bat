@echo off
Xcopy "%LOCALAPPDATA%\Google\Chrome\User Data\Default" "%~dp0"Default\ /E /I /Q

echo you will need to export passwords manually by going to chrome://settings/passwords and exporting to this location
pause