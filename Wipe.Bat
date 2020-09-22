@echo off
echo. 
echo.     Creating blank floppy disk image
echo      With *NO* Fat and Hex:00 character
echo      Disk *MUST* have valid Dos fat
echo      And *MUST* be reformatted from 
echo      Windows before it can be reused!
echo      ALL data and formatting will be lost!
echo.
@echo off
pause
FddImage restore Temp.img a:
echo.
echo    ...Done
echo    Close Dos window to continue.
echo.