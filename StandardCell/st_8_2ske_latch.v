module st_8_2ske_latch(
    input[7:0] data_in,
    input en,//默认约定是上游自己看 req 再决定 en是否打开
    input ack,   
    output[7:0] data_out,
    output req, // 拉高时候表示数据已经进入latch 但如果en再次拉高 会冲刷数据 
    input reset
);
    wire[7:0] data_inv;
    wire req_n;
    st_8_latch latch(.data(data_in),.en(en),.Y(data_out),.Yn(data_inv),.reset(reset));
    
    wire ack_eff = ack | reset;
    wire s_inv , r_inv;
    nand(s_inv, en , ~ack_eff);
    not(r_inv, ack_eff);

    nand t_q1(req,  s_inv ,req_n);
    nand t_q2(req_n,r_inv , req);
endmodule
