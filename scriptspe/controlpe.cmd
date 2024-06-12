@REM @echo off
curl -o %SystemRoot%\prework.cmd http://192.168.5.1/autoinstallwindows/scriptspe/startautoinstall.cmd
start /wait %SystemRoot%\prework.cmd
start /wait %SystemRoot%\work.cmd
shutdown /r /t 3
