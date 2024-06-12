@REM @echo off
start /min c:\download\scripts\disablenetwork.cmd
for %%a in ("c:\download\software\*.msi") do (
    start /wait %%a /passive /norestart
)
shutdown /r /t 1
