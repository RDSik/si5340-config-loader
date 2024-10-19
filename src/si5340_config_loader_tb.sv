`include "environment.sv"
`timescale 1ns/1ps

module si5340_config_loader_tb();

    si5340_config_loader_if dut_if();
    environment env;

    localparam CLK_PER  = 8;
    localparam SIM_TIME = 20000;
                                                         
    si5340_config_loader #(
        .PAUSE_NS (10)
    ) dut (
        .clk_i        (dut_if.clk_i       ),
        .arstn_i      (dut_if.arstn_i     ),
        .load         (dut_if.load        ),
        .write        (dut_if.write       ),
        .scl_pad_i    (dut_if.scl_pad_i   ),
        .scl_pad_o    (dut_if.scl_pad_o   ),
        .scl_padoen_o (dut_if.scl_padoen_o),
        .sda_pad_i    (dut_if.sda_pad_i   ),
        .sda_pad_o    (dut_if.sda_pad_o   ),
        .sda_padoen_o (dut_if.sda_padoen_o)
    );

    initial begin
        dut_if.clk_i = 0;
        forever begin
            #(CLK_PER/2) dut_if.clk_i = ~dut_if.clk_i;
        end
    end

    initial begin
        env = new(dut_if);
        env.init();
    end

    initial begin
        $dumpfile("si5340_config_loader_tb.vcd");
        $dumpvars(0, si5340_config_loader_tb);
        $monitor("time=%g, load=%b, write=%b", $time, dut_if.load, dut_if.write);
    end
    
    initial begin
        #SIM_TIME $finish;
    end

endmodule