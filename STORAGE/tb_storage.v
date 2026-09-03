`timescale 1ps/1ps
module tb_storage;
    reg[7:0] memo_type;
    wire[7:0] memo_addr;
    reg valid_memo;

    reg [31:0] tb_flash [0:1023];
    initial $readmemh("STORAGE/flash_memo.hex",tb_flash);

    wire[31:0] memo_data = tb_flash[memo_addr];
    reg reset;
    reg ack;
    wire req;
    st_memo_register _st_memo_register(memo_type, valid_memo, memo_data,memo_addr,ack,req,reset);
    
    initial begin
        $dumpfile("tb_core.vcd");
        $dumpvars(0,tb_storage);
       // memo_addr = 8'b00000000;
        reset = 1'b1;
        ack = 1'b0;
        memo_type = 8'b00000010;
        valid_memo= 1'b0; 
        #1;
        reset = 1'b0;
        #1;
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