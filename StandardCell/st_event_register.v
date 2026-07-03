module st_event_register(
    input[7:0] data_in,
    input en,
    input rst,
    output[7:0] data_out,
    output req
);
    wire[7:0] data_inv;
    wire req_n;
    st_8_latch latch(.data(data_in),.en(en),.Y(data_out),.Yn(data_inv));
    nand t_and1(req, en, req_n);
    nand t_and2(req_n, rst, req);
endmodule