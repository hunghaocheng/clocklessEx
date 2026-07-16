module st_token_generator(
    input[7:0] data_in,
    input[7:0] type_in,
    input[7:0] source_id,
    input[7:0] flags,
    output[31:0] token_out
);
    assign token_out = {source_id, type_in, data_in, flags};
endmodule