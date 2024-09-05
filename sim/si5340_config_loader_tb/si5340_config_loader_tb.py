import cocotb
import random
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge, ClockCycles
from cocotb.utils import get_sim_time

clk_per = 8

async def reset(dut, cycles):
    dut.arstn_i.value = 0
    await ClockCycles(dut.clk_i, cycles)
    dut.arstn_i.value = 1

@cocotb.test()
async def test_si5340_config_loader(dut):
    
    cocotb.start_soon(Clock(dut.clk_i, clk_per, units = 'ns').start())

    #------------------Order of test execution -------------------
    await reset(dut, 2)