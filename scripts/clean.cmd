@REM @echo off
if "%0" neq "c:\clean.cmd" (
    type %0>c:\clean.cmd
    ping -n 2 127.0.0.1>nul
    start c:\clean.cmd
    exit
)
ping -n 2 127.0.0.1>nul
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V AutoAdminLogon /t reg_sz /d "0" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /f
rd /q /s c:\download
shutdown /r /t 3
del %0
