module st_memo_register(
    input wire[7:0] memo_type,
    input wire valid_memo,
    output wire[7:0] index
);
    wire do_flashToBRAM = valid_memo && (memo_type == 8'b00000010);
    wire do_BRAMToflash = valid_memo && (memo_type == 8'b00000100);
    
    
endmodule