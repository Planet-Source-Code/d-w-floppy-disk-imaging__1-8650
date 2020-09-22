@echo off
echo. 
echo.     Creating Blank Floppy Image
echo      With Clean Fat and Hex: 00 Character
echo.
@echo off
copy /b Dosfat + temp Temp.img
pause
FddImage restore Temp.img a:
echo.
echo   ...Done
echo    Close this window to continue.
echo.