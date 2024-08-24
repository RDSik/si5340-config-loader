import cocotb
import random
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge, ClockCycles
from cocotb.utils import get_sim_time

@cocotb.test()
async def test_config_mem(dut):

    clk_per     = 8
    pause       = 300/clk_per
    cycles      = 3
    word_number = 326
    
    cocotb.start_soon(Clock(dut.clk_i, clk_per, units = 'ns').start())

    # Reset
    async def reset(cycles):
        dut.arstn_i.value = 0
        await ClockCycles(dut.clk_i, cycles)
        dut.arstn_i.value = 1

    # Input data generation
    async def data_gen(n, n_cycles):
        for i in range(n):
            dut.ack_i.value = 1
            await Timer(clk_per, units="ns")
            dut.ack_i.value = 0
            for i in range(n_cycles):
                await Timer(pause, units="ns")
        print(f'Generation ended at {get_sim_time('ns')} ns.')

    #------------------Order of test execution -------------------
    dut.ack_i.value = 0
    await reset(1)
    await data_gen(word_number, cycles)
