module si5340_config_loader #(
    parameter [15:0] CLK_CNT     = 4, // 4x SCL
    parameter        CONFIG_MEM  = "config.mem",
    parameter        MEM_WIDTH   = 24,
    parameter        WORD_NUMBER = 326,
    parameter        DATA_WIDTH  = 8,
    parameter        CLK_FREQ    = 125_000_000
) (
    input wire clk_i,
    input wire arstn_i,

    // I2C
    inout wire sda, // SCL-line
    inout wire scl  // SDA-line
);

    wire [DATA_WIDTH-1:0] data;
    wire                  ack;

    wire scl_pad_i;    // SCL-line input
    wire scl_pad_o;    // SCL-line output (always 1'b0)
    wire scl_padoen_o; // SCL-line output enable (active low)
    wire sda_pad_i;    // SDA-line input
    wire sda_pad_o;    // SDA-line output (always 1'b0)
    wire sda_padoen_o; // SDA-line output enable (active low)

    assign scl_pad_i = scl;
    assign sda_pad_i = sda;
    assign scl       = scl_padoen_o ? 1'bz : scl_pad_o;
    assign sda       = sda_padoen_o ? 1'bz : sda_pad_o;

    i2c_master_byte i2c_inst (
        .clk     (clk_i       ),
        .rst     (0           ),
        .nReset  (arstn_i     ),
        .ena     (1           ),
        .clk_cnt (CLK_CNT     ),
        .start   (),
        .stop    (),
        .read    (),
        .write   (),
        .ack_in  (),
        .din     (data        ),
        .dout    (),
        .cmd_ack (ack         ),
        .ack_out (),
        .scl_i   (scl_pad_i   ),
        .scl_o   (scl_pad_o   ),
        .sda_i   (sda_pad_i   ),
        .sda_o   (sda_pad_o   ),
        .scl_oen (scl_padoen_o),
        .sda_oen (sda_padoen_o)
    );

    mem_serializer #(
        .CONFIG_MEM  (CONFIG_MEM ),
        .MEM_WIDTH   (MEM_WIDTH  ),
        .WORD_NUMBER (WORD_NUMBER),
        .DATA_WIDTH  (DATA_WIDTH ),
        .CLK_FREQ    (CLK_FREQ   )
    ) serializer_inst (
        .clk_i   (clk_i  ),
        .arstn_i (arstn_i),
        .ack_i   (ack    ),
        .data_o  (data   )
    );

    `ifdef COCOTB_SIM
        initial begin
            $dumpfile ("si5340_config_loader.vcd");
            $dumpvars (0, si5340_config_loader);
            #1;
        end
    `endif

endmodule
