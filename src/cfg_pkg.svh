`ifndef CFG_PKG_SVH
`define CFG_PKG_SVH

`include "timescale.v"

package cfg_pkg;

    parameter [15:0] CLK_CNT = 4;                        // 4x SCL

    parameter CONFIG_MEM = "config.mem";
    parameter MEM_DEPTH  = 326;
    parameter MEM_WIDTH  = 24;
    parameter DATA_WIDTH = 8;
    parameter CYCLES     = MEM_WIDTH/DATA_WIDTH;         // need 3 cycles to transmit 24 bit for 8 bit data output and pause between every byte

    parameter CLK_FREQ   = 125_000_000;                  // clock freaquency
    parameter PERIOD_NS  = 1_000_000_000/CLK_FREQ; // period of clock cycle in ns
    // parameter PAUSE_NS   = (300 * 1_000_000)/PERIOD_NS;  // delay 300 msec(300_000_000 ns) and 8 ns period
    
    parameter SLAVE_ADDR = 7'b111_0100;                  // [6:0] 1110100 - addr, [7] - read/write bit

    typedef enum logic {
        WRITE = 1'b0, 
        READ  = 1'b1
    } r_w;

endpackage

`endif
