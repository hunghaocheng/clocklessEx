module st_flash_to_bram(
    input wire[31:0] memo_data,
    input wire memo_valid,
    input wire[7:0] memo_addr,
    input wire ack,
    output wire req,
    input wire reset
);
    st_2_en_valid_hs u_hs(reset, memo_valid & req, memo_addr);
    st_mula_bram mula(memo_data,memo_valid,memo_addr,ack,req,reset);
endmodule