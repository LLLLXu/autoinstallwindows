@REM @echo off
start /min c:\download\scripts\disablenetwork.cmd
start /wait c:\download\software\office\setup.exe /configure c:\download\software\office\All2021VolumeX64.xml
shutdown /r /t 1
