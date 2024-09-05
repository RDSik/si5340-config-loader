import cocotb
import random
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge, ClockCycles
from cocotb.utils import get_sim_time

clk_per     = 8
pause       = 10
cycles      = 3
word_number = 326

async def reset(dut, cycles):
    dut.arstn_i.value = 0
    await ClockCycles(dut.clk_i, cycles)
    dut.arstn_i.value = 1

async def data_gen(dut, n, m):
    await Timer(clk_per, units="sec")
    dut.ack_i.value = 1
    await Timer(clk_per, units="sec")
    dut.ack_i.value = 0
    await Timer(pause*clk_per, units="sec")
    for i in range(m):
        for j in range(n):
            await Timer(clk_per, units="sec")
            dut.ack_i.value = 1
            await Timer(clk_per, units="sec")
            dut.ack_i.value = 0
            await Timer(pause*clk_per, units="sec")
    print(f'Generation ended at {get_sim_time('ns')} ns.')

@cocotb.test()
async def test_mem_serializer(dut):
    
    cocotb.start_soon(Clock(dut.clk_i, clk_per, units = 'sec').start())

    #------------------Order of test execution -------------------
    dut.ack_i.value = 0
    await reset(dut, 2)
    await data_gen(dut, cycles, word_number)
