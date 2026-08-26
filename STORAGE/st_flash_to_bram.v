module st_flash_to_bram(
    output wire[7:0] memo_addr,
    input wire[7:0] memo_data,
    input wire valid,
    output wire req,
    input ack
);
    wire[7:0] data_out;
    st_mula_bram mula(memo_data,valid,data_out,req,ack);
endmodule