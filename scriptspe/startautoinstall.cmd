@echo off
echo ������ʼװ������������ȡ������ֱ�ӹرմ˴���
echo ������ʹ�ô˼�������û���
echo ��ʱ����ʹ��������0
set user=temp
set /p user=
if "%user%" equ "0" (set user=temp)
echo �����Զ�������������y
set partconfirm=none
set /p partconfirm=
if /i "%partconfirm%" neq "y" (set partconfirm=n)
mkdir %SystemRoot%\download
echo %user%>%SystemRoot%\download\user.txt
echo %partconfirm%>%SystemRoot%\download\partconfirm.txt
set address=192.168.5.1
curl -s -o %SystemRoot%\work.cmd http://%address%/autoinstallwindows/scriptspe/autoinstallwork.cmd
:setipc
net use \\%address%\ipc$ "anonymous" /user:"anonymous" 2>nul
ping -n 2 127.0.0.1>nul
if errorlevel 1 goto setipc
:setdrive
net use o: \\%address%\pxe 2>nul
if errorlevel 1 goto setdrive
exit
