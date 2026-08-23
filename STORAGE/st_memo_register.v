module st_memo_register(
    input wire[7:0] memo_type,
    input wire valid_memo,
    output wire[7:0] memo_addr_0,
    input wire[7:0] memo_data
);
    wire do_flashToBRAM = valid_memo && (memo_type == 8'b00000010);
    wire do_BRAMToflash = valid_memo && (memo_type == 8'b00000100);
    assign memo_addr_0 = 8'b00000000;

    wire req_0;
    wire need_write_0 = do_flashToBRAM && (~req_0);
    st_flash_to_bram flashToBram_0(.memo_addr(memo_addr_0),.memo_data(memo_data),.valid(do_flashToBRAM),.req(req_0));

    wire req_1;
    wire[7:0] memo_addr_1;
    wire cout_0_to_1; // 看计算结果有没有超过8位
    st_8bit_adder adder_0_to_1 (memo_addr_0,8'b00000001,1'b0,memo_addr_1,cout_0_to_1);
    
    st_flash_to_bram flashToBram_1(.memo_addr(memo_addr_1),.memo_data(memo_data),.valid(do_flashToBRAM),.req(req_1));
    
endmodule