@echo off
for /f "delims=" %%x in (config.txt) do (set "%%x")

setlocal enabledelayedexpansion

set SEED_DIRECTORY=%USERPROFILE%\%INSTALL_DIR%
if "%CD%"=="%SEED_DIRECTORY%" (
    echo Script is running from %SEED_DIRECTORY%
) else (
    if not exist "%SEED_DIRECTORY%" (
        echo Creating Folder: %SEED_DIRECTORY%
        mkdir "%SEED_DIRECTORY%"
        
    ) else (
        echo Folder already exists.

    )

    echo Copying Files 
    copy /y "enable.bat" "%SEED_DIRECTORY%\"
    copy /y "disable.bat" "%SEED_DIRECTORY%\"
    copy /y "script.bat" "%SEED_DIRECTORY%\"
    copy /y "task.xml" "%SEED_DIRECTORY%\"
    copy /y "config.txt" "%SEED_DIRECTORY%\"
)

set JQ_DIRECTORY=%USERPROFILE%\%INSTALL_DIR%\jq
if not exist %JQ_DIRECTORY% mkdir %JQ_DIRECTORY%

curl -L %JQ_URL% -o %JQ_DIRECTORY%\jq.exe

echo Installed jq to %JQ_DIRECTORY%


schtasks /delete /tn "GOF Seed" /f >nul2>nul

schtasks /create /xml task.xml /tn "GOF Seed" /IT
echo Scheduled task created.


echo Installation has finished this window will close in 5 seconds...
timeout /t 5 >nul