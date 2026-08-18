`timescale 1ps/1ps
module tb_storage;
    reg[7:0] memo_trans_type;
    reg valid_memo;

    reg [7:0] tb_flash [0:15];
    wire[7:0] flash_addr, flash_rdata;
    initial $readmemh("STORAGE/flash_memo.hex",tb_flash);
    //assign flash_rdata = tb_flash[flash_addr];

    st_memo_register flash_to_bram(memo_trans_type,valid_memo, tb_flash_0,);
        
        wire [7:0] tb_flash_0 = tb_flash[0];
        wire [7:0] tb_flash_1 = tb_flash[1];
        wire [7:0] tb_flash_2 = tb_flash[2];
        wire [7:0] tb_flash_3 = tb_flash[3];
        wire [7:0] tb_flash_4 = tb_flash[4];    
    initial begin
        $dumpfile("tb_core.vcd");
        $dumpvars(0,tb_storage);

        
        valid_memo = 1'b0;
        memo_trans_type = 8'b00000010;
        #5;
        valid_memo = 1'b1;
        #10;
        valid_memo= 1'b0;
        #10;
        
    end
endmodule