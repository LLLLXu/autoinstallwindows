@REM @echo off
start /min c:\download\scripts\disablenetwork.cmd
for %%a in ("c:\download\software\*.cmd") do (
    call %%a
)
shutdown /r /t 1
