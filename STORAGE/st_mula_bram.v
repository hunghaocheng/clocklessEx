module st_mula_bram (
    input[7:0] data,
    input en,
    output [7:0] data_out,
    output req
);
    wire[7:0] Yn;
    //st_event_register bram(.data_in(data),.en(en),.ack(ack),.data_out(data_out),.req(req));
    st_8_latch bram0(.data(data),.en(en),.Y(data_out),.Yn(Yn));
    assign req = | data_out;
endmodule