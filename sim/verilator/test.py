import os
import shutil
from pathlib import Path

import cocotb
from cocotb.runner import get_runner

def test_runner():
    src = Path("../../src")
    
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "verilator")
    
    build_dir = Path('sim_si5340_config_loader')
    build_dir.mkdir(exist_ok=True)

    shutil.copyfile(src / 'config.mem', build_dir / 'config.mem')
    shutil.copyfile(src / 'cfg_pkg.svh', build_dir / 'cfg_pkg.svh')
    shutil.copyfile(src / 'timescale.v', build_dir / 'timescale.v')
    shutil.copyfile(src / 'i2c_master_defines.v', build_dir / 'i2c_master_defines.v')

    verilog_sources = [
        src / "cfg_pkg.svh",
        src / "i2c_ctrl_if.sv",
        src / "i2c_master_bit_ctrl.v",
        src / "i2c_master_byte_ctrl.v",
        src / "i2c_master_byte_ctrl.v",
        src / "i2c_master_defines.v",
        src / "timescale.v",
        "si5340_config_loader.sv",
    ]

    hdl_toplevel = 'si5340_config_loader' # HDL module name
    test_module = 'si5340_config_loader_tb' # Python module name
    # pre_cmd = ['do ../wave.do'] # Macro file
    # parameters = {"PAUSE_NS": "10"} # HDL module parameters
    build_args = ['--no-timing', '--assert', '-Wno-MODDUP']

    runner = get_runner(sim)
    
    runner.build(
        verilog_sources=verilog_sources,
        hdl_toplevel=hdl_toplevel,
        build_dir=build_dir,
        always=True, # Always rebuild project
        build_args=build_args,
    )

    runner.test(
        hdl_toplevel=hdl_toplevel,
        test_module=test_module,
        waves=True,
        gui=True,
        # pre_cmd=pre_cmd,
        # parameters=parameters,
    )
    
