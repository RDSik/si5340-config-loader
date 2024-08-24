import os
import shutil
from pathlib import Path

import cocotb
from cocotb.runner import get_runner

def test_runner():
    src = Path("../../src")
    
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "icarus")
    
    build_dir = Path('sim_si5340_config_loader')
    build_dir.mkdir(exist_ok=True)

    shutil.copyfile(src / 'config.mem', build_dir / 'config.mem')

    verilog_sources = [
        src / "config_mem.v",
        src / "i2c_master_byte_ctrl.v",
        src / "i2c_master_bit_ctrl.v",
        src / "i2c_master_defines.v",
        src / "timescale.v",
        src / "si5340_config_loader.v",
    ]
    
    hdl_toplevel = 'si5340_config_loader' # HDL module name
    test_module = 'si5340_config_loader_tb' # Python module name
    # pre_cmd = ['do ../wave.do'] # Macro file

    runner = get_runner(sim)
    
    runner.build(
        verilog_sources=verilog_sources,
        hdl_toplevel=hdl_toplevel,
        build_dir=build_dir,
        always=True, # Always rebuild project
    )

    runner.test(
        hdl_toplevel=hdl_toplevel,
        test_module=test_module,
        waves=True,
        gui=True,
        # pre_cmd=pre_cmd,
    )
    
