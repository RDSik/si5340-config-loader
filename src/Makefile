TOP_NAME  := si5340_config_loader
VERILATOR := verilator
GTKWAVE   := gtkwave
SRC_DIR   := ./
TB_DIR    := tb/
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

all: build execute simulate

build:
	$(VERILATOR) --binary $(SRC_FILES) --trace --trace-params --trace-structs -I$(SRC_DIR) -I$(TB_DIR) --top $(TOP_NAME)_tb

execute:
	./obj_dir/V$(TOP_NAME)_tb

simulate: 
	$(GTKWAVE) $(GTKW_FILE)

clean:
	rm -rf obj_dir
	rm $(TOP_NAME)_tb.vcd
