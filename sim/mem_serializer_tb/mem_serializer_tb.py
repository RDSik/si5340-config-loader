import cocotb
import random
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge, ClockCycles
from cocotb.utils import get_sim_time

clk_per     = 8
pause       = 300/clk_per
cycles      = 3
word_number = 326

async def reset(dut, cycles):
    dut.arstn_i.value = 0
    await ClockCycles(dut.clk_i, cycles)
    dut.arstn_i.value = 1

async def data_gen(dut, n, n_cycles):
    for i in range(n):
        dut.ack_i.value = 1
        await Timer(clk_per, units="ns")
        dut.ack_i.value = 0
        for i in range(n_cycles):
            await Timer(pause, units="ns")
    print(f'Generation ended at {get_sim_time('ns')} ns.')

@cocotb.test()
async def test_mem_serializer(dut):
    
    cocotb.start_soon(Clock(dut.clk_i, clk_per, units = 'ns').start())

    #------------------Order of test execution -------------------
    dut.ack_i.value = 0
    await reset(dut, 1)
    await data_gen(dut, word_number, cycles)
