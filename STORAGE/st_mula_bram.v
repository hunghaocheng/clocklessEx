module st_mula_bram (
    input[31:0] data,
    input wire memo_valid,
    input wire[7:0] memo_addr,
    input wire ack,
    output wire[255:0] datas_out,
    output wire[7:0] reqs_out,
    input reset
);
    wire req_0, req_1, req_2, req_3, req_4, req_5, req_6, req_7;
    assign datas_out = {data_out_7, data_out_6, data_out_5, data_out_4, data_out_3, data_out_2, data_out_1, data_out_0};
    wire[31:0] data_out_0 ,data_out_1, data_out_2, data_out_3, data_out_4, data_out_5, data_out_6, data_out_7;
    st_32_2ske_latch _32latch0(.data_in(data),.en(memo_valid  & (memo_addr[2:0] == 3'd0)),.ack(ack),.data_out(data_out_0),.req(req_0),.reset(reset));
    st_32_2ske_latch _32latch1(.data_in(data),.en(memo_valid  & (memo_addr[2:0] == 3'd1)),.ack(ack),.data_out(data_out_1),.req(req_1),.reset(reset));
    st_32_2ske_latch _32latch2(.data_in(data),.en(memo_valid  & (memo_addr[2:0] == 3'd2)),.ack(ack),.data_out(data_out_2),.req(req_2),.reset(reset));
    st_32_2ske_latch _32latch3(.data_in(data),.en(memo_valid  & (memo_addr[2:0] == 3'd3)),.ack(ack),.data_out(data_out_3),.req(req_3),.reset(reset));
    st_32_2ske_latch _32latch4(.data_in(data),.en(memo_valid  & (memo_addr[2:0] == 3'd4)),.ack(ack),.data_out(data_out_4),.req(req_4),.reset(reset));
    st_32_2ske_latch _32latch5(.data_in(data),.en(memo_valid  & (memo_addr[2:0] == 3'd5)),.ack(ack),.data_out(data_out_5),.req(req_5),.reset(reset));
    st_32_2ske_latch _32latch6(.data_in(data),.en(memo_valid  & (memo_addr[2:0] == 3'd6)),.ack(ack),.data_out(data_out_6),.req(req_6),.reset(reset));
    st_32_2ske_latch _32latch7(.data_in(data),.en(memo_valid  & (memo_addr[2:0] == 3'd7)),.ack(ack),.data_out(data_out_7),.req(req_7),.reset(reset));
    assign reqs_out = {req_7, req_6, req_5, req_4, req_3, req_2, req_1, req_0};
endmodule