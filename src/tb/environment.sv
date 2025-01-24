`ifndef ENV_SV
`define ENV_SV

`include "../timescale.v"
class environment;

    localparam NUMBER = 1;

    local virtual si5340_config_loader_if dut_if;

    function new(virtual si5340_config_loader_if dut_if);
        this.dut_if = dut_if;
    endfunction

    task rst_gen();
        begin
            dut_if.arstn_i = 0;
            @(posedge dut_if.clk_i);
            $display("Reset done at %g ns", $time);
            $display("-----------------------------------------");
            dut_if.arstn_i = 1;
        end
    endtask

    task run();
        begin
            $display("-----------------------------------------");
            $display("Start simulation");
            $display("-----------------------------------------");
            dut_if.clk_i = 0;
            rst_gen();
            rd_gen();
            wr_gen();
            $display("Stop simulation at %g ns", $time);
            $display("-----------------------------------------");
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
                repeat (256) @(posedge dut_if.clk_i);
                $display("Get cmd_ack at %g ns.", $time);
                $display("-----------------------------------------");
                repeat (750) @(posedge dut_if.clk_i);
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
                repeat (256) @(posedge dut_if.clk_i);
                $display("Get cmd_ack at %g ns.", $time);
                $display("-----------------------------------------");
                repeat (1300) @(posedge dut_if.clk_i);
            end
        end
    endtask

endclass

`endif
