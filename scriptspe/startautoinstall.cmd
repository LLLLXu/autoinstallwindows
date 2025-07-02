@echo off
echo 即将开始装机工作，如需取消，请直接关闭此窗口
echo 请输入使用此计算机的用户名
echo 暂时无人使用请输入0
set user=temp
set /p user=
if "%user%" equ "0" (set user=temp)
set fullname=%user%
if "%user%" neq "temp" (
	echo 请输入此用户的显示名称
	echo 直接显示用户名请输入0
	set /p fullname=
	if "%fullname%" equ "0" (set fullname=%user%)
)
echo 如需自动分区，请输入y
set partconfirm=none
set /p partconfirm=
if /i "%partconfirm%" neq "y" (set partconfirm=n)
mkdir %SystemRoot%\download
echo %user%>%SystemRoot%\download\user.txt
echo %fullname%>>%SystemRoot%\download\user.txt
echo %partconfirm%>%SystemRoot%\download\partconfirm.txt
set address=pxe.9th-tech.com
curl -s -o %SystemRoot%\work.cmd http://%address%/autoinstallwindows/scriptspe/autoinstallwork.cmd
:setipc
net use \\%address%\ipc$ "anonymous" /user:"anonymous" 2>nul
ping -n 2 127.0.0.1>nul
if errorlevel 1 goto setipc
:setdrive
net use o: \\%address%\pxe 2>nul
if errorlevel 1 goto setdrive
exit
