TOP := si5340_config_loader

SIM        ?= verilator
MACRO_FILE := wave.do

PARSER      := config_parser.py
PYTHON      := python3
CONFIG_FILE := Si5340-RevD-Si5340-Registers.txt

SRC_DIR := src/
TB_DIR  := src/tb/

SRC_FILES += $(TB_DIR)environment.sv
SRC_FILES += $(TB_DIR)si5340_config_loader_if.sv
SRC_FILES += $(TB_DIR)si5340_config_loader_tb.sv
SRC_FILES += $(SRC_DIR)si5340_config_loader.sv
SRC_FILES += $(SRC_DIR)cfg_pkg.svh
SRC_FILES += $(SRC_DIR)i2c_master_bit_ctrl.v
SRC_FILES += $(SRC_DIR)i2c_master_byte_ctrl.v
SRC_FILES += $(SRC_DIR)i2c_master_defines.v
SRC_FILES += $(SRC_DIR)timescale.v

.PHONY: all wave clean

all: mem_gen build run

mem_gen:
	$(PYTHON) $(SRC_DIR)$(PARSER) $(SRC_DIR)$(CONFIG_FILE)

build:
ifeq ($(SIM), verilator)
	$(SIM) --binary $(SRC_FILES) --trace -I$(SRC_DIR) -I$(TB_DIR) --top $(TOP)_tb
else ifeq ($(SIM), iverilog)
	$(SIM) -g2005-sv -o $(TOP) $(SRC_FILES)
else ifeq ($(SIM), questa)
	vsim -do $(TB_DIR)$(MACRO_FILE)
endif

run:
ifeq ($(SIM), verilator)
	./obj_dir/V$(TOP)_tb
else ifeq ($(SIM), iverilog)
	vvp $(TOP)
endif

wave: 
	gtkwave $(TOP)_tb.vcd

clean:
	rm -rf obj_dir
	rm -rf work
	rm *.vcd
