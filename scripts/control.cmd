@REM @echo off
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /v software /t reg_sz /d "C:\download\scripts\control.cmd" /f
set now=10
for /f "tokens=1 delims=," %%a in ('type c:\download\scripts\step.txt') do set now=%%a&goto stepend
:stepend
set /a next=%now%+1
echo %next%>c:\download\scripts\step.txt
start c:\download\scripts\%now%.cmd
