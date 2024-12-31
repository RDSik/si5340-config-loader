import os
import shutil
from pathlib import Path

import cocotb
from cocotb.runner import get_runner

def test_runner():
    src = Path("../src")
    
    hdl_toplevel_lang = os.getenv("HDL_TOPLEVEL_LANG", "verilog")
    sim = os.getenv("SIM", "questa")
    
    build_dir = Path('sim_si5340_config_loader')
    build_dir.mkdir(exist_ok=True)

    shutil.copyfile(src / 'config.mem', build_dir / 'config.mem')

    verilog_sources = []

    def files(path):
        sources = []
        for child in path.iterdir():
            if child.is_file() and (str(child).endswith('.v') or str(child).endswith('.sv') or str(child).endswith('.svh')):
                sources.append(child)
        return sources

    verilog_sources.extend(files(src))
    
    hdl_toplevel = 'si5340_config_loader' # HDL module name
    test_module = 'si5340_config_loader_tb' # Python module name
    pre_cmd = ['do ../wave.do'] # Macro file
    parameters = {"PAUSE_NS": "10"} # HDL module parameters

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
        pre_cmd=pre_cmd,
        parameters=parameters,
    )
    
