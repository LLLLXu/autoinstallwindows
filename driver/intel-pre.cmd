@REM @echo off
mkdir c:\download\driver\3
xcopy /e /y o:\autoinstallwindows\driver\public\intel c:\download\driver\3\intel\
echo start /wait c:\download\driver\3\intel\Installer.exe /passive /noExtras>c:\download\driver\3\intel.cmd
