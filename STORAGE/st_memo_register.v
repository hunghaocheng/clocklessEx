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

    wire req_0,req_1,req_2,req_3;
    wire ack_0 = memo_acks[0],ack_1 = memo_acks[1],ack_2 = memo_acks[2],ack_3 = memo_acks[3];
    st_2_en_valid_hs u_hs(reset, valid_memo, memo_addr);


    st_flash_to_bram flashToBram_0(.memo_data(memo_data),.valid(do_flashToBRAM && (memo_addr == 8'b00000000)),.req(req_0),.ack(ack_0),.reset(reset));
    st_flash_to_bram flashToBram_1(.memo_data(memo_data),.valid(do_flashToBRAM && (memo_addr == 8'b00000001)),.req(req_1),.ack(ack_1),.reset(reset));
    st_flash_to_bram flashToBram_2(.memo_data(memo_data),.valid(do_flashToBRAM && (memo_addr == 8'b00000010)),.req(req_2),.ack(ack_2),.reset(reset));
    st_flash_to_bram flashToBram_3(.memo_data(memo_data),.valid(do_flashToBRAM && (memo_addr == 8'b00000011)),.req(req_3),.ack(ack_3),.reset(reset));

    //st_flash_to_bram flashToBram_0(.memo_data(memo_data),.valid(do_flashToBRAM),.req(req_0),.ack(ack_0),.reset(reset));

endmodule