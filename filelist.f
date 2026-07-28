# clocklessEx Verilog filelist
# Usage:
#   iverilog -o sim.out -f filelist.f -s <top_module>
#   vvp sim.out
# Example:
#   iverilog -o COREPROCESS/tb_coreprocess.out -f filelist.f -s tb_coreprocess
#   vvp COREPROCESS/tb_coreprocess.out

# ---------- StandardCell ----------
StandardCell/st_c_element.v
StandardCell/st_mutex.v
StandardCell/st_delay_line.v
StandardCell/st_reset.v
StandardCell/st_glitch_free_mux.v
StandardCell/st_2_encoder.v
StandardCell/st_latch.v
StandardCell/st_8_latch.v
StandardCell/st_32_latch.v
StandardCell/st_half_adder.v
StandardCell/st_full_adder.v
StandardCell/st_4bit_adder.v
StandardCell/st_8bit_adder.v
StandardCell/st_16bit_adder.v
StandardCell/st_event_register.v
StandardCell/st_fifo.v

# ---------- COREPROCESS ----------
COREPROCESS/st_node.v
COREPROCESS/st_relation.v

# ---------- CORE ----------
CORE/Process.v

# ---------- FIFO ----------
FIFO/FIFO_cache.v

# ---------- LANGUAGE ----------
LANGUAGE/driven.v

# ---------- GUI ----------
GUI/ddr3_frame.v
GUI/HDMI_api.v
GUI/sim_hdmi.v

# ---------- Root ----------
press.v

# ---------- Testbenches ----------
COREPROCESS/tb_coreprocess.v
CORE/tb_Process.v
FIFO/tb_FIFO_cache.v
StandardCell/tb_st_latch.v
StandardCell/tb_st_half_adder.v
StandardCell/tb_st_full_adder.v
StandardCell/tb_st_16bit_adder.v
tb_press.v
