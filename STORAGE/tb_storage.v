`timescale 1ps/1ps
module tb_storage;
    reg[7:0] memo_trans_type;
    wire[7:0] flash_addr;
    reg valid_memo;

    reg [31:0] tb_flash [0:1023];
    wire[31:0]  flash_rdata, flash_0, flash_1, flash_2, flash_3;
    initial $readmemh("STORAGE/flash_memo.hex",tb_flash);
    assign flash_rdata = tb_flash[flash_addr];
    reg reset;
    assign memo_acks = 8'b00000000;
    st_memo_register _st_memo_register(memo_trans_type, valid_memo, flash_rdata,memo_acks,flash_addr,reset);
    
    initial begin
        $dumpfile("tb_core.vcd");
        $dumpvars(0,tb_storage);
        //flash_addr = 8'b00000000;
        reset = 1'b1;
        //valid_memo= 1'b0; 
        #2;
        reset = 1'b0;
        #3;
        //valid_memo= 1'b0; 
        memo_trans_type = 8'b00000010;
        #5;//1st
        valid_memo = 1'b1;
        #1;
        valid_memo= 1'b0;
        #1;//2nd
        valid_memo = 1'b1;
        #1;
        valid_memo= 1'b0;
        #1;//3rd
        valid_memo = 1'b1;
        #1;
        valid_memo= 1'b0;
        #1;//4th
        valid_memo = 1'b1;
        #1;
        valid_memo= 1'b0;
        #1;//5th
        valid_memo = 1'b1;
        #1;
        valid_memo= 1'b0;
        #1;//6th
        valid_memo = 1'b1;
        #1;
        valid_memo= 1'b0;
        #1;//7th
        valid_memo = 1'b1;
        #1;
        valid_memo= 1'b0;
        #1;//8th
        valid_memo = 1'b0;
        #1;
        valid_memo = 1'b1;
        #1;
        valid_memo= 1'b0;
        #1;//9th
        valid_memo = 1'b1;
        #1;
        valid_memo= 1'b0;
        #1;//10th
        valid_memo = 1'b1;
        #1;
    end
endmodule  