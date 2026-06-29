module st_node(
    input wire[7:0] signal_in,
    input wire en,
    output wire[7:0] signal_out
);
    wire[7:0] signal_inv;
    st_8_latch latch(signal_in,en,signal_out,signal_inv);

endmodule