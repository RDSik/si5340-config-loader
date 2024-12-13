// Status: Testing

`include "cfg_pkg.svh"

module si5340_config_loader 
    import cfg_pkg::*;
#(
    parameter CONFIG_MEM = "config.mem",
    parameter PAUSE_NS   = cfg_pkg::PAUSE_NS
) (
    input logic clk_i,
    input logic arstn_i,
    input logic load_i,
    input logic write_i,

    // inout wire sda, // SCL-line
    // inout wire scl  // SDA-line

    // I2C
    input  scl_pad_i,    // SCL-line input
    output scl_pad_o,    // SCL-line output (always 1'b0)
    output scl_padoen_o, // SCL-line output enable (active low)
    input  sda_pad_i,    // SDA-line input
    output sda_pad_o,    // SDA-line output (always 1'b0)
    output sda_padoen_o  // SDA-line output enable (active low)
);

    // wire scl_pad_i;    // SCL-line input
    // wire scl_pad_o;    // SCL-line output (always 1'b0)
    // wire scl_padoen_o; // SCL-line output enable (active low)
    // wire sda_pad_i;    // SDA-line input
    // wire sda_pad_o;    // SDA-line output (always 1'b0)
    // wire sda_padoen_o; // SDA-line output enable (active low)

    // assign scl_pad_i = scl;
    // assign sda_pad_i = sda;
    // assign scl       = scl_padoen_o ? 1'bz : scl_pad_o;
    // assign sda       = sda_padoen_o ? 1'bz : sda_pad_o;

    i2_ctrl_if s_i2_ctrl_if();

    i2c_master_byte_ctrl i2c_inst (
        .clk     (clk_i               ),
        .rst     (0                   ),
        .nReset  (arstn_i             ),
        .ena     (1                   ),
        .clk_cnt (CLK_CNT             ),
        .start   (s_i2_ctrl_if.start  ),
        .stop    (s_i2_ctrl_if.stop   ),
        .read    (s_i2_ctrl_if.read   ),
        .write   (s_i2_ctrl_if.write  ),
        .ack_in  (s_i2_ctrl_if.ack_in ),
        .din     (s_i2_ctrl_if.din    ),
        .cmd_ack (s_i2_ctrl_if.cmd_ack),
        .ack_out (                    ),
        .i2c_busy(                    ),
        .i2c_al  (                    ),
        .dout    (s_i2_ctrl_if.dout   ),
        .scl_i   (scl_pad_i           ),
        .scl_o   (scl_pad_o           ),
        .sda_i   (sda_pad_i           ),
        .sda_o   (sda_pad_o           ),
        .scl_oen (scl_padoen_o        ),
        .sda_oen (sda_padoen_o        )
    );

    localparam QUEUE_WIDTH = 6;

    logic [$clog2(QUEUE_WIDTH)-1:0] queue_index;
    logic [$clog2(QUEUE_WIDTH)-1:0] queue_len;

    logic [$clog2(PAUSE_NS)-1:0 ] pause_cnt;
    logic [$clog2(MEM_DEPTH)-1:0] mem_index;

    logic [MEM_WIDTH-1:0] mem [MEM_DEPTH-1:0]; // [23:8] - addr, [7:0] - data

    struct packed {
        logic [DATA_WIDTH-1:0] data;
        r_w                    rw;
        logic                  start;
        logic                  stop;
    } queue [QUEUE_WIDTH-1:0];

    enum logic [2:0] {
        IDLE        = 3'b000,
        ACK         = 3'b001,
        WAIT_ACK    = 3'b010,
        PAUSE       = 3'b011,
        QUEUE_INDEX = 3'b100,
        MEM_INDEX   = 3'b101,
        STOP        = 3'b110,
        WAIT_STOP   = 3'b111
    } state;

    initial $readmemh(CONFIG_MEM, mem);
    
    always_ff @(posedge clk_i or negedge arstn_i) begin
        if (~arstn_i) begin
            pause_cnt   <= 0;
            mem_index   <= 0;
            queue_index <= 0;
            state       <= IDLE;
        end else begin
            case (state)
                IDLE: if (load_i) state <= ACK;
                      else state <= IDLE;
                ACK: state <= WAIT_ACK;
                WAIT_ACK: if (s_i2_ctrl_if.cmd_ack) begin
                    if (queue[queue_index].stop) state <= STOP;
                    else state <= PAUSE;
                end
                PAUSE: if (pause_cnt == PAUSE_NS) begin
                    pause_cnt <= 0;
                    state     <= QUEUE_INDEX;
                end else begin
                    pause_cnt <= pause_cnt + 1;
                    state     <= PAUSE;
                end
                MEM_INDEX: begin
                    state <= IDLE;
                    if (mem_index == MEM_DEPTH - 1) mem_index <= 0;
                    else mem_index <= mem_index + 1;
                end
                QUEUE_INDEX: if (queue_index == queue_len) begin 
                    queue_index <= 0;
                    state       <= MEM_INDEX;
                end else begin
                    queue_index <= queue_index + 1;
                    state       <= ACK;
                end
                STOP: state <= WAIT_STOP;
                WAIT_STOP: if (s_i2_ctrl_if.cmd_ack) state <= QUEUE_INDEX;
                           else state <= WAIT_STOP;
                default: state <= IDLE;
            endcase
        end
    end

    always_comb begin
        s_i2_ctrl_if.din = queue[queue_index].data;
        if (state == ACK || state == STOP) s_i2_ctrl_if.ack_in = 1;
        else s_i2_ctrl_if.ack_in = 0;
        if (state == ACK && queue[queue_index].start) s_i2_ctrl_if.start = 1;
        else s_i2_ctrl_if.start = 0;
        if (state == STOP && queue[queue_index].stop) s_i2_ctrl_if.stop = 1;
        else s_i2_ctrl_if.stop = 0;
        if (state == ACK && queue[queue_index].rw == READ) s_i2_ctrl_if.read = 1;
        else s_i2_ctrl_if.read = 0;
        if (state == ACK && queue[queue_index].rw == WRITE) s_i2_ctrl_if.write = 1;
        else s_i2_ctrl_if.write = 0;
    end

    always_ff @(posedge clk_i) begin
        if (~arstn_i) queue_len <= 0;
        else if (state == IDLE && load_i) begin
            if (write_i) begin // Write
                queue[0]  <= {{SLAVE_ADDR, WRITE}, WRITE, 1'b1, 1'b0};
                queue[1]  <= {mem[mem_index][(CYCLES-1)*DATA_WIDTH +: DATA_WIDTH], WRITE, 1'b0, 1'b0}; // [23:16] - addr
                queue[2]  <= {mem[mem_index][(CYCLES-2)*DATA_WIDTH +: DATA_WIDTH], WRITE, 1'b0, 1'b0}; // [15:8]  - addr
                queue[3]  <= {mem[mem_index][(CYCLES-3)*DATA_WIDTH +: DATA_WIDTH], WRITE, 1'b0, 1'b1}; // [7:0]   - data
                queue_len <= QUEUE_WIDTH - 3;
            end else begin // Read
                queue[0]  <= {{SLAVE_ADDR, WRITE}, WRITE, 1'b1, 1'b0};
                queue[1]  <= {mem[mem_index][(CYCLES-1)*DATA_WIDTH +: DATA_WIDTH], WRITE, 1'b0, 1'b0}; // [23:16] - addr
                queue[2]  <= {{SLAVE_ADDR, WRITE}, WRITE, 1'b1, 1'b0};
                queue[3]  <= {mem[mem_index][(CYCLES-2)*DATA_WIDTH +: DATA_WIDTH], WRITE, 1'b0, 1'b0}; // [15:8]  - addr
                queue[4]  <= {{SLAVE_ADDR, READ}, WRITE, 1'b1, 1'b0};
                queue[5]  <= {mem[mem_index][(CYCLES-3)*DATA_WIDTH +: DATA_WIDTH], READ, 1'b0, 1'b1};  // [7:0]   - data
                queue_len <= QUEUE_WIDTH - 1;
            end
        end
    end

    `ifdef COCOTB_SIM
        initial begin
            $dumpfile ("si5340_config_loader.vcd");
            $dumpvars (0, si5340_config_loader);
            #1;
        end
    `endif

endmodule
