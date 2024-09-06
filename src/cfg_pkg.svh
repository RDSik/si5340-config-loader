`ifndef CFG_PKG
`define CFG_PKG

package cfg_pkg;

    parameter [15:0] CLK_CNT = 4; // 4x SCL

    parameter MEM_WIDTH   = 24;
    parameter DATA_WIDTH  = 8;
    parameter WORD_NUMBER = 326;

    parameter CLK_FREQ   = 125_000_000;                  // clock freaquency
    parameter PERIOD_NS  = (1/CLK_FREQ) * 1_000_000_000; // period of clock cycle in ns
    parameter PAUSE_NS   = (300 * 1_000_000)/PERIOD_NS;  // delay 300 msec(300_000_000 ns) and 8 ns period
    parameter CYCLES     = MEM_WIDTH/DATA_WIDTH;         // need 3 cycles to transmit 24 bit for 8 bit data output and pause between every byte
    parameter SLAVE_ADDR = 7'b111_0100;                  // [6:0] 1110100 - addr, [7] - read/write bit

    typedef enum logic {
        WRITE = 1'b0, 
        READ  = 1'b1
    } rw;

endpackage

`endif
