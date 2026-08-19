module st_memo_register(
    input wire[7:0] memo_type,
    input wire valid_memo,
    output wire[7:0] memo_addr,
    input wire[7:0] memo_data
);
    wire do_flashToBRAM = valid_memo && (memo_type == 8'b00000010);
    wire do_BRAMToflash = valid_memo && (memo_type == 8'b00000100);
    
    st_flash_to_bram flashToBRAM(.memo_addr(memo_addr),.memo_data(memo_data),.valid(do_flashToBRAM));

    
endmodule