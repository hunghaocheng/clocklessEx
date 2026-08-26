`timescale 1ps/1ps
module tb_storage;
    reg[7:0] memo_trans_type,flash_addr;
    reg valid_memo;

    reg [7:0] tb_flash [0:15];
    wire[7:0]  flash_rdata;
    initial $readmemh("STORAGE/flash_memo.hex",tb_flash);
    assign flash_rdata = tb_flash[flash_addr];
    assign flash_1 = tb_flash[0];
    assign flash_2 = tb_flash[1];
    assign memo_acks = 8'b00000000;
    st_memo_register _st_memo_register(memo_trans_type, valid_memo, flash_addr, flash_rdata,memo_acks);
    
    initial begin
        $dumpfile("tb_core.vcd");
        $dumpvars(0,tb_storage);
        flash_addr = 8'b00000000;
        valid_memo = 1'b0;
        memo_trans_type = 8'b00000010;
        #5;
        valid_memo = 1'b1;
        #5;
        valid_memo= 1'b0;
        #5;
    end
endmodule  