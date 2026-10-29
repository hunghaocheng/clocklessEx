@echo off
cd /d "%~dp0"
iverilog -o COREPROCESS/tb_processing.out -s tb_processing ^
  EventRegister/tb_processing.v ^
  EventRegister/st_processing_unit.v ^
  StandardCell/st_ring_osc.v ^
  StandardCell/st_latch.v ^
  StandardCell/st_3_latch.v ^
  StandardCell/st_8_latch.v ^
  StandardCell/st_8_2ske_latch.v ^
  StandardCell/st_32_latch.v ^
  StandardCell/st_32_2ske_latch.v ^
  StandardCell/st_full_adder.v ^
  StandardCell/st_half_adder.v ^
  StandardCell/st_3bit_adder.v ^
  StandardCell/st_4bit_adder.v ^
  StandardCell/st_8bit_adder.v ^
  STORAGE/st_local_clk_hs.v ^
  STORAGE/st_3bit_8_stepper.v ^
  STORAGE/st_8bit_256_stepper.v ^
  STORAGE/st_mula_bram.v ^
  STORAGE/st_flash_to_bram.v
if errorlevel 1 exit /b 1
vvp -n COREPROCESS/tb_processing.out
if errorlevel 1 exit /b 1
gtkwave tb_processing.vcd
