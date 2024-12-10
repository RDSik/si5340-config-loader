TOP_NAME  := si5340_config_loader
VERILATOR := verilator
GTKWAVE   := gtkwave
SRC_DIR   := src
TB_DIR    := src/tb
MEM_FILE  := config.mem
GTKW_FILE := gtkw.gtkw
SRC_FILES := $(shell find $(SRC_DIR) -name '*.vh')  \
			 $(shell find $(SRC_DIR) -name '*.svh') \
			 $(shell find $(SRC_DIR) -name '*.v')   \
			 $(shell find $(SRC_DIR) -name '*.sv')  \
			 $(shell find $(TB_DIR) -name '*.vh')   \
			 $(shell find $(TB_DIR) -name '*.svh')  \
			 $(shell find $(TB_DIR) -name '*.v')    \
			 $(shell find $(TB_DIR) -name '*.sv')

.PHONY: all clean

all: copy_file build execute simulate

copy_file:
	$(shell cp $(SRC_DIR)/$(MEM_FILE) ./)

build:
	$(VERILATOR) --trace --binary $(SRC_FILES) -I$(SRC_DIR) -I$(TB_DIR) --top $(TOP_NAME)_tb

execute:
	./obj_dir/V$(TOP_NAME)_tb

simulate: 
	$(GTKWAVE) $(GTKW_FILE)

clean:
	rm -rf obj_dir
	rm $(MEM_FILE) $(TOP_NAME)_tb.vcd
