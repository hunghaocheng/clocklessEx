module st_1_to_4_router(
    input[31:0] token_in,
    input rst,
    output[31:0] token_out1,
    output[31:0] token_out2,
    output[31:0] token_out3,
    output[31:0] token_out4
);

    assign token_out1 = token_in;
    assign token_out2 = token_in;
    assign token_out3 = token_in;
    assign token_out4 = token_in;


endmodule