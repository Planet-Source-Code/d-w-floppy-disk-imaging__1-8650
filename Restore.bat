@echo off
echo. 
echo.     Restoring Selected Image to Floppy
echo      All Existing Data on Disk will be lost!
echo.
@echo off
pause
FddImage restore Temp.img a:
echo.
echo   ...Done
echo    Close this window to continue.
echo.