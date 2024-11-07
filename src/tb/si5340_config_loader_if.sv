/* verilator lint_off MODDUP */
interface si5340_config_loader_if;

    bit clk_i;
    bit arstn_i;
    bit load_i;
    bit write_i;

    logic scl_pad_i;
    logic scl_pad_o;
    logic scl_padoen_o;
    logic sda_pad_i;
    logic sda_pad_o;
    logic sda_padoen_o;

endinterface