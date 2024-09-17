onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /si5340_config_loader/clk_i
add wave -noupdate /si5340_config_loader/arstn_i
add wave -noupdate /si5340_config_loader/load
add wave -noupdate /si5340_config_loader/write
add wave -noupdate /si5340_config_loader/scl_pad_i
add wave -noupdate /si5340_config_loader/scl_pad_o
add wave -noupdate /si5340_config_loader/scl_padoen_o
add wave -noupdate /si5340_config_loader/sda_pad_i
add wave -noupdate /si5340_config_loader/sda_pad_o
add wave -noupdate /si5340_config_loader/sda_padoen_o
add wave -noupdate /si5340_config_loader/state
add wave -noupdate /si5340_config_loader/pause_cnt
add wave -noupdate /si5340_config_loader/mem_index
add wave -noupdate /si5340_config_loader/queue_index
add wave -noupdate /si5340_config_loader/queue_len
add wave -noupdate /si5340_config_loader/queue
add wave -noupdate /si5340_config_loader/i2c_inst/clk
add wave -noupdate /si5340_config_loader/i2c_inst/rst
add wave -noupdate /si5340_config_loader/i2c_inst/nReset
add wave -noupdate /si5340_config_loader/i2c_inst/ena
add wave -noupdate /si5340_config_loader/i2c_inst/clk_cnt
add wave -noupdate /si5340_config_loader/i2c_inst/start
add wave -noupdate /si5340_config_loader/i2c_inst/stop
add wave -noupdate /si5340_config_loader/i2c_inst/read
add wave -noupdate /si5340_config_loader/i2c_inst/write
add wave -noupdate /si5340_config_loader/i2c_inst/ack_in
add wave -noupdate /si5340_config_loader/i2c_inst/din
add wave -noupdate /si5340_config_loader/i2c_inst/cmd_ack
add wave -noupdate /si5340_config_loader/i2c_inst/ack_out
add wave -noupdate /si5340_config_loader/i2c_inst/i2c_busy
add wave -noupdate /si5340_config_loader/i2c_inst/i2c_al
add wave -noupdate /si5340_config_loader/i2c_inst/dout
add wave -noupdate /si5340_config_loader/i2c_inst/scl_i
add wave -noupdate /si5340_config_loader/i2c_inst/scl_o
add wave -noupdate /si5340_config_loader/i2c_inst/scl_oen
add wave -noupdate /si5340_config_loader/i2c_inst/sda_i
add wave -noupdate /si5340_config_loader/i2c_inst/sda_o
add wave -noupdate /si5340_config_loader/i2c_inst/sda_oen
add wave -noupdate /si5340_config_loader/i2c_inst/core_cmd
add wave -noupdate /si5340_config_loader/i2c_inst/core_txd
add wave -noupdate /si5340_config_loader/i2c_inst/core_ack
add wave -noupdate /si5340_config_loader/i2c_inst/core_rxd
add wave -noupdate /si5340_config_loader/i2c_inst/sr
add wave -noupdate /si5340_config_loader/i2c_inst/shift
add wave -noupdate /si5340_config_loader/i2c_inst/ld
add wave -noupdate /si5340_config_loader/i2c_inst/go
add wave -noupdate /si5340_config_loader/i2c_inst/dcnt
add wave -noupdate /si5340_config_loader/i2c_inst/cnt_done
add wave -noupdate /si5340_config_loader/i2c_inst/c_state
add wave -noupdate /si5340_config_loader/s_i2_ctrl_if/din
add wave -noupdate /si5340_config_loader/s_i2_ctrl_if/dout
add wave -noupdate /si5340_config_loader/s_i2_ctrl_if/start
add wave -noupdate /si5340_config_loader/s_i2_ctrl_if/stop
add wave -noupdate /si5340_config_loader/s_i2_ctrl_if/read
add wave -noupdate /si5340_config_loader/s_i2_ctrl_if/write
add wave -noupdate /si5340_config_loader/s_i2_ctrl_if/ack_in
add wave -noupdate /si5340_config_loader/s_i2_ctrl_if/cmd_ack
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
