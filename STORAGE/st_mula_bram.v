module st_mula_bram (
    input[31:0] data,
    input en,
    output [31:0] data_out,
    output req,
    input ack,
    input reset
);
    wire[31:0] Yn;
    wire req_0, req_1, req_2, req_3;
    assign req = req_0 | req_1 | req_2 | req_3;
    st_event_register _event0(.data_in(data[7:0]),.en(en),.ack(ack),.data_out(data_out[7:0]),.req(req_0),.reset(reset));
    st_event_register _event1(.data_in(data[15:8]),.en(en),.ack(ack),.data_out(data_out[15:8]),.req(req_1),.reset(reset));
    st_event_register _event2(.data_in(data[23:16]),.en(en),.ack(ack),.data_out(data_out[23:16]),.req(req_2),.reset(reset));
    st_event_register _event3(.data_in(data[31:24]),.en(en),.ack(ack),.data_out(data_out[31:24]),.req(req_3),.reset(reset));
endmodule