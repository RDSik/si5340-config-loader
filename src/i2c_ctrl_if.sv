`include "cfg_pkg.svh"

import cfg_pkg::DATA_WIDTH;

interface i2_ctrl_if;

    logic [DATA_WIDTH-1:0] din;
    logic [DATA_WIDTH-1:0] dout;
    logic                  start;
    logic                  stop;
    logic                  read;
    logic                  write;
    logic                  ack_in;
    logic                  cmd_ack;

    modport master (
        input  dout,
        input  cmd_ack,
        output start,
        output stop,
        output read,
        output write,
        output ack_in,
        output din
    );

    modport slave (
        input  start,
        input  stop,
        input  read,
        input  write,
        input  ack_in,
        input  din,
        output dout,
        output cmd_ack
    );

endinterface
