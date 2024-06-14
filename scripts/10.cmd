@REM @echo off
start /min c:\download\scripts\disablenetwork.cmd
net user %username% temp@123.com
wmic UserAccount Where Name="%username%" Set PasswordExpires="false"
set hostname=none
for /f "tokens=1 delims=," %%a in ('type c:\download\hostname.txt') do set hostname=%%a&goto hostnameend
:hostnameend
pnputil /add-driver c:\download\driver\2\*.inf /install /subdirs
@REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t reg_sz /d "1" /f
@REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /t reg_sz /d "%USER%" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /t reg_sz /d "temp@123.com" /f
@REM wmic computersystem where "name='%computername%'" call rename "%hostname%"
wmic computersystem where name="%computername%" call rename "%hostname%"
shutdown /r /t 1
