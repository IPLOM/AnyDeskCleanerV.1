@echo off
setlocal enabledelayedexpansion

:: Set URL for updated script
set "url=http://example.com/updated_script.bat"

:: Set text color to black
color 0F

:: Clear the screen
cls

:: Display UI Header
echo ====================================================
echo               Anydesk Process Reset Tool
echo ====================================================
echo.
echo Developed by IPL
echo.
echo.
echo  Main Menu:
echo.
echo  1. **Press Select to Spoof Anydesk** - Spoof Anydesk and clear cache
echo  2. **Exit** - Exit the program
echo.
echo  3. **Check for updates** - Check for updates and update the script
echo.

:: Get user input
set /p choice=Choose an option: 

:: Process user input
if %choice%==1 goto spoof_anydesk
if %choice%==2 exit
if %choice%==3 goto update_script
goto main

:spoof_anydesk
:: Set status message
set "status=Spoofing Anydesk..."

:: Display status message
echo %status%

:: Determine operating system type (32-bit or 64-bit)
if exist "c:\Program Files (x86)" (
    set "ostype=64-bit"
) else (
    set "ostype=32-bit"
)

:: Terminate Anydesk Process
echo Terminating Anydesk Process...
for /f "tokens=2" %%A in ('tasklist /FI "IMAGENAME eq Anydesk.exe" /NH') do (
    echo Terminating PID %%A
    tskill %%A >nul
)

:: Clear the screen
cls

:: Reset Anydesk Configuration
#Change The Name Of The User It Be IPL Change It To Make it Work 
echo Resetting Anydesk Configuration...
cd /d C:\Users\IPL\AppData\Roaming\AnyDesk\
if exist system.conf.backup del /f /q system.conf.backup
if exist service.conf.backup del /f /q service.conf.backup
if exist system.conf rename system.conf system.conf.backup
if exist service.conf rename service.conf service.conf.backup

:: Determine the correct Anydesk directory based on OS type
if %ostype%==64-bit (
    set "pdir=C:\Program Files (x86)\AnyDesk\"
) else (
    set "pdir=C:\Program Files\AnyDesk\"
)

:: Start Anydesk
cd /d "%pdir%"
start Anydesk.exe

:: Set status message to "Spoofing complete!"
set "status=Spoofing complete!"

:: Display status message
echo %status%

:: Display completion message
cls
echo ====================================================
echo               Anydesk Process Reset Tool
echo ====================================================
echo.
echo Developed by IPL
echo.
echo Anydesk has been reset and restarted successfully.
echo.
pause
goto main

:update_script
:: Create a temporary file for the updated script
set "temp_file=%temp%\updated_anyspoofer.tmp"

:: Use cURL to download the updated script
curl -f -s -o "%temp_file%" "%url%"

:: Check if the download was successful
if exist "%temp_file%" (
    :: Replace the existing script with the updated script
    copy /y "%temp_file%" "%~f0"
    echo Script updated successfully!
    
    :: Run the new version
    start "" "%~f0"
    exit /b
) else (
    echo Failed to update script.
)

:: Clean up
del /q "%temp_file%"
goto main
