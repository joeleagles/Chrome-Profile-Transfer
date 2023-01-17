@echo off


REM --> Script Made By Joel Eagles




REM  --> this will run the script as admin (stole this section from someone online)

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------  



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
