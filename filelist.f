# clocklessEx unified Verilog filelist (paths relative to project root)
# Usage:
#   iverilog -o <out> -s <top_module> -c filelist.f
#   vvp <out>

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
StandardCell/st_32_2ske_latch.v
StandardCell/st_half_adder.v
StandardCell/st_full_adder.v
StandardCell/st_4bit_adder.v
StandardCell/st_8bit_adder.v
StandardCell/st_16bit_adder.v
StandardCell/st_8_2ske_latch.v
StandardCell/st_fifo.v
StandardCell/st_token_generator.v
StandardCell/st_1_to_4_router.v
StandardCell/st_neuron_txn.v
StandardCell/st_synapse.v

# ---------- COREPROCESS ----------
COREPROCESS/st_node.v
COREPROCESS/st_relation.v
COREPROCESS/neuron_cluster_testdata.v
COREPROCESS/physical_model_testdata.v

# ---------- CORE ----------
CORE/Process.v

# ---------- FIFO ----------
FIFO/FIFO_cache.v

# ---------- FORMULA ----------
FORMULA/st_formula.v

# ---------- LANGUAGE ----------
LANGUAGE/driven.v

# ---------- STORAGE ----------
STORAGE/st_mula_bram.v
STORAGE/st_flash_to_bram.v
STORAGE/st_memo_register.v
STORAGE/st_local_clk_hs.v
STORAGE/st_2_en_valid_hs.v

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
FORMULA/tb_formula.v
FORMULA/tb_formula_coreprocess.v
StandardCell/tb_st_latch.v
StandardCell/tb_st_half_adder.v
StandardCell/tb_st_full_adder.v
StandardCell/tb_st_16bit_adder.v
StandardCell/tb_st_neuron_txn.v
STORAGE/tb_storage.v
STORAGE/tb_local_clk_hs.v
tb_press.v
