@REM @echo off
start /min c:\download\scripts\disablenetwork.cmd
for /f "skip=1 tokens=1 delims=," %%a in ('type c:\download\user.txt') do set fullname=%%a&goto fullnameend
:fullnameend
net user %username% temp@123.com
@REM wmic useraccount where name="%username%" Set PasswordExpires="false"
powershell Set-LocalUser -Name "%username%" -PasswordNeverExpires $true
net user %username% /fullname:"%fullname%"
set hostname=none
for /f "tokens=1 delims=," %%a in ('type c:\download\hostname.txt') do set hostname=%%a&goto hostnameend
:hostnameend
pnputil /add-driver c:\download\driver\2\*.inf /install /subdirs
@REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t reg_sz /d "1" /f
@REM reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /t reg_sz /d "%USER%" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /t reg_sz /d "temp@123.com" /f

@REM wmic computersystem where name="%computername%" call rename "%hostname%"
@REM powershell Rename-Computer -NewName "%hostname%" -Force -PassThru
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\ComputerName\ComputerName" /v ComputerName /t reg_sz /d "%hostname%" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Tcpip\Parameters" /v "NV Hostname" /t reg_sz /d "%hostname%" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName" /v ComputerName /t reg_sz /d "%hostname%" /f
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "NV Hostname" /t reg_sz /d "%hostname%" /f

netsh advfirewall firewall add rule name="Allow ICMPv4-In" protocol=icmpv4:8,any dir=in action=allow

reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t reg_dword /d "0x00000001" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\Orchestrator\UScheduler_Oobe" /v BlockedOobeUpdaters /t reg_sz /d \"MS_Outlook\" /f
powershell Remove-AppxProvisionedPackage -AllUsers -Online -PackageName (Get-AppxPackage Microsoft.OutlookForWindows).PackageFullName

shutdown /r /t 1
