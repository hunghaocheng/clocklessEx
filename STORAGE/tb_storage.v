`timescale 1ps/1ps
module tb_storage;
    reg[31:0] memo_trans_type;
    reg[9:0] flash_addr;
    reg valid_memo;

    reg [31:0] tb_flash [0:1023];
    wire[31:0]  flash_rdata, flash_0, flash_1, flash_2, flash_3;
    initial $readmemh("STORAGE/flash_memo.hex",tb_flash);
    assign flash_rdata = tb_flash[flash_addr];

    assign flash_0 = tb_flash[0];
    assign flash_1 = tb_flash[1];
    assign flash_2 = tb_flash[2];
    assign flash_3 = tb_flash[3];
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