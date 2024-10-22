import shutil
from pathlib import Path

action = "simulation"
sim_tool = "modelsim"
sim_top = "si5340_config_loader_tb"

sim_post_cmd = "vsim -do wave.do -i si5340_config_loader_tb"

modules = {
    "local" : [ 
        "../../../src/tb/",
    ],
}

mem_file_path = Path("../../../src")

shutil.copyfile(mem_file_path / 'config.mem', 'config.mem')