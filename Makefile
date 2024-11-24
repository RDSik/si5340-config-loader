TOP_NAME := si5340_config_loader
SRC_DIR  := src
TB_DIR   := src/tb
MEM_FILE := config.mem
GTK_FILE := gtkw.gtkw
SRC_FILES := $(shell find $(SRC_DIR) -name '*.vh')  \
			 $(shell find $(SRC_DIR) -name '*.svh') \
			 $(shell find $(SRC_DIR) -name '*.v')   \
			 $(shell find $(SRC_DIR) -name '*.sv')  \
			 $(shell find $(TB_DIR) -name '*.vh')   \
			 $(shell find $(TB_DIR) -name '*.svh')  \
			 $(shell find $(TB_DIR) -name '*.v')    \
			 $(shell find $(TB_DIR) -name '*.sv')

.PHONY: all clean

all: copy_file build execute sim

copy_file:
	$(shell cp $(SRC_DIR)/$(MEM_FILE) ./)

build:
	verilator --trace --binary $(SRC_FILES) -I$(SRC_DIR) -I$(TB_DIR) --top $(TOP_NAME)_tb

execute:
	./obj_dir/V$(TOP_NAME)_tb

sim: 
	gtkwave $(GTK_FILE)

clean:
	rm -rf obj_dir
	rm $(MEM_FILE)
	rm $(TOP_NAME)_tb.vcd