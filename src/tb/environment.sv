`ifndef ENV_SV
`define ENV_SV

`include "../timescale.v"

class environment;

    localparam CLK_PER = 8;
    localparam NUMBER  = 1;

    local virtual si5340_config_loader_if dut_if;

    function new(virtual si5340_config_loader_if dut_if);
        this.dut_if = dut_if;
    endfunction

    task rst_gen();
        begin
            dut_if.arstn_i = 0;
            #CLK_PER;
            dut_if.arstn_i = 1;
        end
    endtask

    task run();
        begin        
            dut_if.clk_i = 0;
            rst_gen();
            rd_gen();
            wr_gen();
        end
    endtask

    task wr_gen();
        begin
            repeat(NUMBER) begin
                dut_if.write_i = 1;
                dut_if.load_i = 1;
                $display("Load and Write at %g ns.", $time);
                $display("-----------------------------------------");
                @(posedge dut_if.clk_i);
                dut_if.write_i = 0;
                dut_if.load_i = 0;
                #(CLK_PER*256);
                $display("Get cmd_ack at %g ns.", $time);
                $display("-----------------------------------------");
                #(CLK_PER*750);
            end
        end
    endtask

    task rd_gen();
        begin
            repeat(NUMBER) begin
                dut_if.write_i = 0;
                dut_if.load_i = 1;
                $display("Load and Read at %g ns.", $time);
                $display("-----------------------------------------");
                @(posedge dut_if.clk_i);
                dut_if.write_i = 0;
                dut_if.load_i = 0;
                #(CLK_PER*256);
                $display("Get cmd_ack at %g ns.", $time);
                $display("-----------------------------------------");
                #(CLK_PER*1300);
            end
        end
    endtask

endclass

`endif
