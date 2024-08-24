import os
import shutil
from pathlib import Path

import cocotb
from cocotb.runner import get_runner

def test_runner():
    src = Path("../../src")
    
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "icarus")
    
    build_dir = Path('sim_i2c_master_byte_ctrl')
    build_dir.mkdir(exist_ok=True)

    verilog_sources = [
        src / "i2c_master_byte_ctrl.v",
        src / "i2c_master_bit_ctrl.v",
        src / "i2c_master_defines.v",
        src / "timescale.v",
    ]
    
    hdl_toplevel = 'i2c_master_byte_ctrl' # HDL module name
    test_module = 'i2c_master_byte_ctrl_tb' # Python module name
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
    
