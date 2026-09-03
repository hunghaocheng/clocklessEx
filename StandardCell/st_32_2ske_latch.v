module st_32_2ske_latch(
    input wire[31:0] data_in,
    input wire en,
    input wire ack,
    output wire[31:0] data_out,
    output wire req,
    input wire reset
);
    wire[31:0] data_inv;
    wire req_n;
    st_32_latch u_latch(.data(data_in),.en(en),.Y(data_out),.Yn(data_inv),.reset(reset));
    
    wire ack_eff = ack | reset;
    wire s_inv , r_inv;
    nand(s_inv, en , ~ack_eff);
    not(r_inv, ack_eff);

    nand(req,  s_inv ,req_n);
    nand(req_n,r_inv , req);

endmodule