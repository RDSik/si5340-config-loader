import os
import shutil
from pathlib import Path

import cocotb
from cocotb.runner import get_runner

def test_runner():
    src = Path("../../src")
    
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "icarus")
    
    build_dir = Path('sim_mem_serializer')
    build_dir.mkdir(exist_ok=True)

    shutil.copyfile(src / 'config.mem', build_dir / 'config.mem')

    verilog_sources = [
        src / "mem_serializer.v",
    ]
    
    hdl_toplevel = 'mem_serializer' # HDL module name
    test_module = 'mem_serializer_tb' # Python module name
    # pre_cmd = ['do ../wave.do'] # Macro file
    parameters = {"CLK_FREQ": "125"} # HDL module parameters

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
        parameters=parameters,
    )
    
