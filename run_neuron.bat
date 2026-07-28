@echo off
cd /d "%~dp0"
iverilog -o StandardCell/tb_st_neuron_txn.out -s tb_st_neuron_txn -c sources_neuron.f
if errorlevel 1 exit /b 1
vvp -n StandardCell/tb_st_neuron_txn.out
if errorlevel 1 exit /b 1
gtkwave tb_st_neuron_txn.vcd
