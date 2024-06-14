@REM @echo off
mkdir c:\download\driver\3
xcopy /e /y o:\autoinstallwindows\driver\public\intel6-10 c:\download\driver\3\intel6-10\
echo start /wait c:\download\driver\3\intel6-10\Installer.exe /passive /noExtras>c:\download\driver\3\intel6-10.cmd
