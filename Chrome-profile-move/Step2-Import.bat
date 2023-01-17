@echo off
taskkill /F /IM chrome.exe /T > nul
TIMEOUT /T 2

rmdir "%LOCALAPPDATA%\Google\Chrome\User Data\Default\" /S /Q
Xcopy "%~dp0"Default\ "%LOCALAPPDATA%\Google\Chrome\User Data\Default\" /Q

RENAME "%~dp0Chrome Passwords.csv" "ChromePasswords.csv"

echo this script will now delete the copied profile.
echo please ensure everything is copied into chrome before continuing.
echo Make sure to import the passwords manually
cd C:\Program Files\Google\Chrome\Application\
chrome.exe -enable-features=PasswordImport
pause
rmdir "%~dp0"Default\ /S /Q
echo are you ready to delete password backup?
pause
del "%~dp0ChromePasswords.csv"