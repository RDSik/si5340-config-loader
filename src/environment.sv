`ifndef _ENV_SV_
`define _ENV_SV_

class environment;

    localparam CLK_PER = 8;

    local virtual si5340_config_loader_if dut_if;

    function new(virtual si5340_config_loader_if dut_if);
        this.dut_if = dut_if;
    endfunction

    task reset();
        begin
            dut_if.arstn_i = 0;
            #CLK_PER;
            dut_if.arstn_i = 1;
        end
    endtask

    task write(n);
        begin
            repeat(n)
                begin
                    dut_if.write = 1;
                    dut_if.load = 1;
                    $display("Load and Write at %g ns.", $time);
                    #(CLK_PER*2);
                    dut_if.write = 0;
                    dut_if.load = 0;
                    #(CLK_PER*256);
                    $display("Get cmd_ack at %g ns.", $time);
                    #(CLK_PER*750);
                end
        end
    endtask

    task read(n);
        begin
            repeat(n)
                begin
                    dut_if.write = 0;
                    dut_if.load = 1;
                    $display("Load and Read at %g ns.", $time);
                    #(CLK_PER*2);
                    dut_if.write = 0;
                    dut_if.load = 0;
                    #(CLK_PER*256);
                    $display("Get cmd_ack at %g ns.", $time);
                    #(CLK_PER*1300);
                end
        end
    endtask

    task init();
        begin
            reset();
            read(1);
            write(1);
        end
    endtask

endclass

`endif