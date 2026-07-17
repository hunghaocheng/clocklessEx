module st_1_to_4_router(
    input[31:0] token_in,
    input rst,
    output[31:0] token_out1,
    output[31:0] token_out2,
    output[31:0] token_out3,
    output[31:0] token_out4
);

    assign data_out1 = data_in;
    assign data_out2 = data_in;
    assign data_out3 = data_in;
    assign data_out4 = data_in;
endmodule