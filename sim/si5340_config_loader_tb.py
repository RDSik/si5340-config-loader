import cocotb
import random
import logging
from cocotb.clock import Clock
from cocotb.triggers import Timer, RisingEdge, FallingEdge, ClockCycles
from cocotb.utils import get_sim_time

clk_per = 8

class Test:
    def __init__(self, dut):
        self.dut = dut

        self.log = logging.getLogger('cocotb.tb')
        self.log.setLevel(logging.DEBUG)

        dut.arstn_i.setimmediatevalue(0)
        dut.load_i.setimmediatevalue(0)
        dut.write_i.setimmediatevalue(0)
        
        cocotb.start_soon(Clock(self.dut.clk_i, clk_per, units = 'ns').start())

    async def init(self):
        await self.reset(2)
        await self.read(1)
        await self.write(1)

    async def reset(self, cycles):
        self.dut.arstn_i.value = 0
        await ClockCycles(self.dut.clk_i, cycles)
        self.dut.arstn_i.value = 1

    async def write(self, n):
        for i in range(n):
            self.dut.load_i = 1
            self.dut.write_i = 1
            self.dut.log.info(f"Load and Write at {get_sim_time('ns')} ns.")
            await Timer(clk_per*2, units="ns")
            self.dut.load_i = 0
            self.dut.write_i = 0
            await Timer(clk_per*256, units="ns")
            self.dut.log.info(f"Get cmd_ack at {get_sim_time('ns')} ns.")
            await Timer(clk_per*750, units="ns")

    async def read(self, n):
        for i in range(n):
            self.dut.load_i = 1
            self.dut.write_i = 0
            self.dut.log.info(f"Load and Read at {get_sim_time('ns')} ns.")
            await Timer(clk_per*2, units="ns")
            self.dut.load_i = 0
            self.dut.write_i = 0
            await Timer(clk_per*256, units="ns")
            self.dut.log.info(f"Get cmd_ack at {get_sim_time('ns')} ns.")
            await Timer(clk_per*1300, units="ns")

@cocotb.test()
async def run_test(dut):

    #------------------Order of test execution -------------------
    tb = Test(dut)
    await tb.init()
