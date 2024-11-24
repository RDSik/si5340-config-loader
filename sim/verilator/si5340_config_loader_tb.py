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

async def write(dut, n):
    for i in range(n):
        dut.load = 1
        dut.write = 1
        print(f"Load and Write at {get_sim_time('ns')} ns.")
        await Timer(clk_per*2, units="ns")
        dut.load = 0
        dut.write = 0
        await Timer(clk_per*256, units="ns")
        print(f"Get cmd_ack at {get_sim_time('ns')} ns.")
        await Timer(clk_per*750, units="ns")

async def read(dut, n):
    for i in range(n):
        dut.load = 1
        dut.write = 0
        print(f"Load and Read at {get_sim_time('ns')} ns.")
        await Timer(clk_per*2, units="ns")
        dut.load = 0
        dut.write = 0
        await Timer(clk_per*256, units="ns")
        print(f"Get cmd_ack at {get_sim_time('ns')} ns.")
        await Timer(clk_per*1300, units="ns")

async def init(dut):

    cocotb.start_soon(Clock(dut.clk_i, clk_per, units = 'ns').start())

    await reset(dut, 2)
    await read(dut, 1)
    await write(dut, 1)

@cocotb.test()
async def test_si5340_config_loader(dut):

    #------------------Order of test execution -------------------
    await init(dut)
