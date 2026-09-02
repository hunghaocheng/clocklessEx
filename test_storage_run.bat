@echo off
cd /d "%~dp0"
iverilog -o COREPROCESS/tb_core.out -s tb_storage -c filelist.f
if errorlevel 1 exit /b 1
vvp -n COREPROCESS/tb_core.out
if errorlevel 1 exit /b 1
gtkwave tb_core.vcd
