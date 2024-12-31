vlib work
vmap work

vlog si5340_config_loader_tb.sv
vlog si5340_config_loader_if.sv
vlog environment.sv
vlog ../i2c_master_bit_ctrl.v
vlog ../i2c_master_byte_ctrl.v
vlog ../i2c_master_defines.v
vlog ../timescale.v
vlog ../si5340_config_loader.sv
vlog ../i2c_ctrl_if.sv
vlog ../cfg_pkg.svh

vsim -voptargs="+acc" si5340_config_loader_tb
add log -r /*

###############################
# Add signals to time diagram #
###############################
add wave -expand -color #ff9911 -radix hex -group TOP \
/si5340_config_loader_tb/dut/clk_i        \
/si5340_config_loader_tb/dut/arstn_i      \
/si5340_config_loader_tb/dut/load_i       \
/si5340_config_loader_tb/dut/write_i      \
/si5340_config_loader_tb/dut/scl_pad_i    \
/si5340_config_loader_tb/dut/scl_pad_o    \
/si5340_config_loader_tb/dut/scl_padoen_o \
/si5340_config_loader_tb/dut/sda_pad_i    \
/si5340_config_loader_tb/dut/sda_pad_o    \
/si5340_config_loader_tb/dut/sda_padoen_o \

add wave -expand -color #cccc00 -radix hex -group OTHERS \
/si5340_config_loader_tb/dut/queue_index \
/si5340_config_loader_tb/dut/queue_len   \
/si5340_config_loader_tb/dut/pause_cnt   \
/si5340_config_loader_tb/dut/mem_index   \
/si5340_config_loader_tb/dut/state       \
/si5340_config_loader_tb/dut/queue       \

add wave -expand -color #ee66ff -radix hex -group I2C_CORE \
/si5340_config_loader_tb/dut/i2c_inst/clk      \
/si5340_config_loader_tb/dut/i2c_inst/rst      \
/si5340_config_loader_tb/dut/i2c_inst/nReset   \
/si5340_config_loader_tb/dut/i2c_inst/ena      \
/si5340_config_loader_tb/dut/i2c_inst/clk_cnt  \
/si5340_config_loader_tb/dut/i2c_inst/start    \
/si5340_config_loader_tb/dut/i2c_inst/stop     \
/si5340_config_loader_tb/dut/i2c_inst/read     \
/si5340_config_loader_tb/dut/i2c_inst/write    \
/si5340_config_loader_tb/dut/i2c_inst/ack_in   \
/si5340_config_loader_tb/dut/i2c_inst/din      \
/si5340_config_loader_tb/dut/i2c_inst/cmd_ack  \
/si5340_config_loader_tb/dut/i2c_inst/ack_out  \
/si5340_config_loader_tb/dut/i2c_inst/i2c_busy \
/si5340_config_loader_tb/dut/i2c_inst/i2c_al   \
/si5340_config_loader_tb/dut/i2c_inst/dout     \
/si5340_config_loader_tb/dut/i2c_inst/scl_i    \
/si5340_config_loader_tb/dut/i2c_inst/scl_o    \
/si5340_config_loader_tb/dut/i2c_inst/scl_oen  \
/si5340_config_loader_tb/dut/i2c_inst/sda_i    \
/si5340_config_loader_tb/dut/i2c_inst/sda_o    \
/si5340_config_loader_tb/dut/i2c_inst/sda_oen  \
/si5340_config_loader_tb/dut/i2c_inst/core_cmd \
/si5340_config_loader_tb/dut/i2c_inst/core_txd \
/si5340_config_loader_tb/dut/i2c_inst/core_ack \
/si5340_config_loader_tb/dut/i2c_inst/core_rxd \
/si5340_config_loader_tb/dut/i2c_inst/sr       \
/si5340_config_loader_tb/dut/i2c_inst/shift    \
/si5340_config_loader_tb/dut/i2c_inst/ld       \
/si5340_config_loader_tb/dut/i2c_inst/go       \
/si5340_config_loader_tb/dut/i2c_inst/dcnt     \
/si5340_config_loader_tb/dut/i2c_inst/cnt_done \
/si5340_config_loader_tb/dut/i2c_inst/c_state  \

run -all
wave zoom full
