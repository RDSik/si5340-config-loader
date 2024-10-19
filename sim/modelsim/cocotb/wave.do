onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -color #ff9911 -radix hex -group TOP \
/si5340_config_loader/clk_i        \
/si5340_config_loader/arstn_i      \
/si5340_config_loader/load         \
/si5340_config_loader/write        \
/si5340_config_loader/scl_pad_i    \
/si5340_config_loader/scl_pad_o    \
/si5340_config_loader/scl_padoen_o \
/si5340_config_loader/sda_pad_i    \
/si5340_config_loader/sda_pad_o    \
/si5340_config_loader/sda_padoen_o \
/si5340_config_loader/state        \

add wave -color #cccc00 -radix hex -group CNT`S \
/si5340_config_loader/pause_cnt   \
/si5340_config_loader/mem_index   \
/si5340_config_loader/queue_index \
/si5340_config_loader/queue_len   \
/si5340_config_loader/queue       \

add wave -color #ee66ff -radix hex -group I2C_CORE \
/si5340_config_loader/i2c_inst/clk      \
/si5340_config_loader/i2c_inst/rst      \
/si5340_config_loader/i2c_inst/nReset   \
/si5340_config_loader/i2c_inst/ena      \
/si5340_config_loader/i2c_inst/clk_cnt  \
/si5340_config_loader/i2c_inst/start    \
/si5340_config_loader/i2c_inst/stop     \
/si5340_config_loader/i2c_inst/read     \
/si5340_config_loader/i2c_inst/write    \
/si5340_config_loader/i2c_inst/ack_in   \
/si5340_config_loader/i2c_inst/din      \
/si5340_config_loader/i2c_inst/cmd_ack  \
/si5340_config_loader/i2c_inst/ack_out  \
/si5340_config_loader/i2c_inst/i2c_busy \
/si5340_config_loader/i2c_inst/i2c_al   \
/si5340_config_loader/i2c_inst/dout     \
/si5340_config_loader/i2c_inst/scl_i    \
/si5340_config_loader/i2c_inst/scl_o    \
/si5340_config_loader/i2c_inst/scl_oen  \
/si5340_config_loader/i2c_inst/sda_i    \
/si5340_config_loader/i2c_inst/sda_o    \
/si5340_config_loader/i2c_inst/sda_oen  \
/si5340_config_loader/i2c_inst/core_cmd \
/si5340_config_loader/i2c_inst/core_txd \
/si5340_config_loader/i2c_inst/core_ack \
/si5340_config_loader/i2c_inst/core_rxd \
/si5340_config_loader/i2c_inst/sr       \
/si5340_config_loader/i2c_inst/shift    \
/si5340_config_loader/i2c_inst/ld       \
/si5340_config_loader/i2c_inst/go       \
/si5340_config_loader/i2c_inst/dcnt     \
/si5340_config_loader/i2c_inst/cnt_done \
/si5340_config_loader/i2c_inst/c_state  \

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {465000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 251
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {848410 ps}

run -all
wave zoom full
