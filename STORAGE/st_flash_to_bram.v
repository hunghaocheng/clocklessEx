module st_flash_to_bram(
    input wire[31:0] memo_data,
    input wire valid,
    output wire req,
    input ack,
    input reset
);
    wire[31:0] data_out;
    st_mula_bram mula(memo_data,valid,data_out,req,ack,reset);
endmodule