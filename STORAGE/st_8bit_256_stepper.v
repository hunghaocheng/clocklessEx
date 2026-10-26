`timescale 1ps/1ps
module st_8bit_256_stepper (
    input  wire       reset,
    input  wire       valid_memo,
    output wire [7:0] addr_out
);
// 8bit 模256步进：步进信号 → 两相使能，addr 每次 +1
    wire [7:0] addr_a, addr_an, addr_b, addr_bn, addr_next;
    wire en_a, en_b, busy, Cout;

    st_8bit_adder adder(addr_b, 8'b00000001, 1'b0, addr_next, Cout);
    st_8_latch latch_a(.data(addr_next), .en(en_a), .Y(addr_a), .Yn(addr_an), .reset(reset));
    st_8_latch latch_b(.data(addr_a),    .en(en_b), .Y(addr_b), .Yn(addr_bn), .reset(reset));

    st_local_clk_hs clk(reset, valid_memo, addr_a, addr_b, addr_next, en_a, en_b, busy);

    assign addr_out = addr_b;
endmodule
