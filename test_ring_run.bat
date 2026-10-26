@echo off
cd /d "%~dp0"
iverilog -o COREPROCESS/tb_ring.out -s tb_test_ring ^
  StandardCell/tb_test_ring.v ^
  StandardCell/st_ring_osc.v ^
  StandardCell/st_latch.v ^
  StandardCell/st_3_latch.v ^
  StandardCell/st_8_latch.v ^
  StandardCell/st_full_adder.v ^
  StandardCell/st_half_adder.v ^
  StandardCell/st_3bit_adder.v ^
  StandardCell/st_4bit_adder.v ^
  StandardCell/st_8bit_adder.v ^
  STORAGE/st_local_clk_hs.v ^
  STORAGE/st_3bit_8_stepper.v ^
  STORAGE/st_8bit_256_stepper.v ^
  STORAGE/st_mula_bram.v ^
  STORAGE/st_flash_to_bram.v ^
  StandardCell/st_32_latch.v ^
  StandardCell/st_32_2ske_latch.v
if errorlevel 1 exit /b 1
vvp -n COREPROCESS/tb_ring.out
if errorlevel 1 exit /b 1
gtkwave tb_ring.vcd
