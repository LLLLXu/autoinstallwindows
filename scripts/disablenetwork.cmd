@echo off
echo 持续禁用网络中
:disablenet
ping -n 2 127.0.0.1>nul
route /f>nul
goto disablenet
