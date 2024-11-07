`ifndef ENV_SV
`define ENV_SV

`timescale 1ns/10ps

class environment;

    localparam CLK_PER = 8;
    localparam NUMBER  = 1;

    local virtual si5340_config_loader_if dut_if;

    function new(virtual si5340_config_loader_if dut_if);
        this.dut_if = dut_if;
    endfunction

    task init();
        begin
            reset();
            read();
            write();
        end
    endtask

    task reset();
        begin
            dut_if.arstn_i = 0;
            $display("Reset at %g ns.", $time);
            #CLK_PER;
            dut_if.arstn_i = 1;
        end
    endtask

    task write();
        begin
            repeat(NUMBER)
                begin
                    dut_if.write_i = 1;
                    dut_if.load_i = 1;
                    $display("Load and Write at %g ns.", $time);
                    #(CLK_PER*2);
                    dut_if.write_i = 0;
                    dut_if.load_i = 0;
                    #(CLK_PER*256);
                    $display("Get cmd_ack at %g ns.", $time);
                    #(CLK_PER*750);
                end
        end
    endtask

    task read();
        begin
            repeat(NUMBER)
                begin
                    dut_if.write_i = 0;
                    dut_if.load_i = 1;
                    $display("Load and Read at %g ns.", $time);
                    #(CLK_PER*2);
                    dut_if.write_i = 0;
                    dut_if.load_i = 0;
                    #(CLK_PER*256);
                    $display("Get cmd_ack at %g ns.", $time);
                    #(CLK_PER*1300);
                end
        end
    endtask

endclass

`endif
