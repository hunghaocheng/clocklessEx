module st_mula_bram (
    input[31:0] data,
    input wire memo_valid,
    input wire[7:0] memo_addr,
    input wire ack,
    output wire req,
    input reset
);
    wire req_0, req_1, req_2, req_3;

    wire[31:0] data_out_0 ,data_out_1, data_out_2, data_out_3;
    st_32_2ske_latch _32latch0(.data_in(data),.en(memo_valid  & (memo_addr == 8'b00000000)),.ack(ack),.data_out(data_out_0),.req(req_0),.reset(reset));
    st_32_2ske_latch _32latch1(.data_in(data),.en(memo_valid  & (memo_addr == 8'b00000001)),.ack(ack),.data_out(data_out_1),.req(req_1),.reset(reset));
    st_32_2ske_latch _32latch2(.data_in(data),.en(memo_valid  & (memo_addr == 8'b00000010)),.ack(ack),.data_out(data_out_2),.req(req_2),.reset(reset));
    st_32_2ske_latch _32latch3(.data_in(data),.en(memo_valid  & (memo_addr == 8'b00000011)),.ack(ack),.data_out(data_out_3),.req(req_3),.reset(reset));

    assign req = req_0 | req_1 | req_2 | req_3;
endmodule