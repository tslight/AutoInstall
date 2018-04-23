@echo off

SET mypath=%~dp0
echo %mypath:~0,-1%

powershell.exe -ExecutionPolicy Bypass -Command "%mypath%\ps\Install.ps1" -Verb RunAs

echo.

pause
