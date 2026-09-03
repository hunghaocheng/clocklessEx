module st_memo_register(
    input wire[7:0] memo_type,
    input wire valid_memo,
    input wire[31:0] memo_data,
    output wire[7:0] memo_addr,
    input wire ack,
    output wire req,
    input wire reset
);
    wire do_flashToBRAM = valid_memo && (memo_type == 8'b00000010);
    wire do_BRAMToflash = valid_memo && (memo_type == 8'b00000100);

    st_flash_to_bram flashToBram(.memo_data(memo_data),.memo_valid(do_flashToBRAM),.memo_addr(memo_addr),.ack(ack),.req(req),.reset(reset));
endmodule