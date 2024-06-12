@REM @echo off
mkdir c:\download\driver\3
xcopy /e /y o:\autoinstallwindows\driver\public\nvidia-quadro c:\download\driver\3\nvidia-quadro\
echo start /wait c:\download\driver\3\nvidia-quadro\setup.exe /passive /noreboot>c:\download\driver\3\nvidia-quadro.cmd
