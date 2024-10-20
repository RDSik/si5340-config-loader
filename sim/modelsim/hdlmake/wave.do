onerror {resume}
quietly WaveActivateNextPane {} 0

add wave -color #ff9911 -radix hex -group TOP \
/si5340_config_loader_tb/dut/clk_i   \
/si5340_config_loader_tb/dut/arstn_i \
/si5340_config_loader_tb/dut/load_i  \
/si5340_config_loader_tb/dut/write_i \

add wave -color #ee66ff -radix hex -group I2C_CORE \
/si5340_config_loader_tb/dut/scl_pad_i    \
/si5340_config_loader_tb/dut/scl_pad_o    \
/si5340_config_loader_tb/dut/scl_padoen_o \
/si5340_config_loader_tb/dut/sda_pad_i    \
/si5340_config_loader_tb/dut/sda_pad_o    \
/si5340_config_loader_tb/dut/sda_padoen_o \

add wave -color #cccc00 -radix hex -group OTHERS \
/si5340_config_loader_tb/dut/queue_index \
/si5340_config_loader_tb/dut/queue_len   \
/si5340_config_loader_tb/dut/pause_cnt   \
/si5340_config_loader_tb/dut/mem_index   \
/si5340_config_loader_tb/dut/state       \

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7650915 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 267
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {21 us}

run -all
wave zoom full
