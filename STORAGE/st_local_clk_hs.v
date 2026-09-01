module st_local_clk_hs (
    input wire reset,
    input wire step_req,
    input wire [7:0] addr_a,
    input wire [7:0] addr_b,
    input wire [7:0] addr_next,
    output wire en_a,
    output wire en_b,
    output wire busy
);
    wire armed, armed_n;
    wire p1_done, p1_n;
    wire p2_done, p2_n;

    wire done_a = (addr_a == addr_next);
    wire done_b = (addr_b == addr_a);

    wire start = step_req & ~armed & ~reset;
    wire clear_all = reset | (~step_req & p2_done);

    wire arm_en = start | clear_all;
    wire arm_d = start | ~clear_all;
    st_latch u_arm(
        .data(arm_d),
        .en(arm_en),
        .Y(armed),
        .Yn(armed_n),
        .reset(1'b0)
    );

    wire in_p1 = armed & ~p1_done & ~reset;
    wire in_p2 = armed & p1_done & ~p2_done & ~reset;

    wire p1_en = (in_p1 & done_a) | clear_all;
    wire p1_d = (in_p1 & done_a) | ~clear_all;

    st_latch u_p1(
        .data(p1_d),
        .en(p1_en),
        .Y(p1_done),
        .Yn(p1_n),
        .reset(1'b0)
    );

    wire p2_en = (in_p2 & done_b) | clear_all;
    wire p2_d = (in_p2 & done_b) & ~clear_all;
    st_latch u_p2(
        .data(p2_d),
        .en(p2_en),
        .Y(p1_done),
        .Yn(p1_n),
        .reset(1'b0)
    );

    assign en_a = in_p1;
    assign en_b = in_p2;
    assign busy = armed & ~p2_done;
endmodule