@echo off
cd /d "%~dp0\.."
iverilog -o STORAGE/tb_local_clk_hs.out -s tb_local_clk_hs -c filelist.f
if errorlevel 1 exit /b 1
vvp -n STORAGE/tb_local_clk_hs.out
if errorlevel 1 exit /b 1
if not exist "tb_clk.vcd" (
    echo ERROR: VCD not found: tb_clk.vcd
    echo Check $dumpfile in tb_local_clk_hs.v
    exit /b 1
)
gtkwave tb_clk.vcd
