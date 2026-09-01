module st_memo_register(
    input wire[7:0] memo_type,
    input wire valid_memo,
    input wire[31:0] memo_data,
    input wire[7:0] memo_acks,
    output wire[7:0] memo_addr,
    input wire reset
);
    wire do_flashToBRAM = valid_memo && (memo_type == 8'b00000010);
    wire do_BRAMToflash = valid_memo && (memo_type == 8'b00000100);

    wire req_0;
    wire ack_0 = memo_acks[0];
    st_flash_to_bram flashToBram_0(.memo_data(memo_data),.valid(do_flashToBRAM),.req(req_0),.ack(ack_0),.reset(reset));



endmodule