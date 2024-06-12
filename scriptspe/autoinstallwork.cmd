@REM @echo off
set sn=none
for /f "tokens=1 delims=," %%a in ('dmidecode.exe -s system-serial-number') do set sn=%%a&goto snend
:snend
set hostname=none
set imagepath=none
set imagenumber=none
set profilefolder=none
for /f "skip=2 tokens=1,4,5,6,7 delims=," %%a in ('find /i "%sn%" o:\autoinstallwindows\profiles\list.csv') do (
    set hostname=%%a
    set imagepath=%%c
    set imagenumber=%%d
    set profilefolder=%%e
    goto profileend
)
:profileend
pnputil /add-driver o:\autoinstallwindows\driver\%profilefolder%\1\*.inf /install /subdirs
ping -n 3 127.0.0.1>nul
xcopy /e /y o:\autoinstallwindows\profiles\%profilefolder% %SystemRoot%\download\profile\
set partconfirm=n
for /f "tokens=1 delims=," %%a in ('type %SystemRoot%\download\partconfirm.txt') do set partconfirm=%%a&goto partconfirmend
:partconfirmend
if /i "%partconfirm%" equ "y" (call %SystemRoot%\download\profile\diskpart.cmd)
imagex /apply o:\autoinstallwindows\image\%imagepath% %imagenumber% c:\
bcdboot c:\windows /s z: /f uefi /l zh-cn

xcopy /e /y %SystemRoot%\download c:\download\
xcopy /e /y o:\autoinstallwindows\driver\%profilefolder% c:\download\driver\
xcopy /e /y o:\autoinstallwindows\scripts c:\download\scripts\
xcopy /e /y o:\autoinstallwindows\software c:\download\software\
for %%a in ("c:\download\driver\*.cmd") do call %%a

echo 10>c:\download\scripts\step.txt
echo %hostname%>c:\download\hostname.txt

dism /image:c:\ /add-driver /driver:c:\download\driver\1\ /recurse /forceunsigned

mkdir c:\Windows\Panther
set user=temp
for /f "tokens=1 delims=," %%a in ('type c:\download\user.txt') do set user=%%a&goto userend
:userend
set /p=<nul>c:\Windows\Panther\Unattend.xml
for /f "tokens=1 delims=," %%a in ('type o:\autoinstallwindows\scriptspe\Unattend.txt') do (
    setlocal enabledelayedexpansion
    set line=%%a
    set line=!line:changethis=%user%!
    echo !line!>>c:\Windows\Panther\Unattend.xml
    endlocal
)

exit
