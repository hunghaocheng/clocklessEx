`timescale 1ns/1ns
module tb_st_latch;

    reg [31:0] data;
    reg en;
    reg reset;
    st_32_latch t_latch(.data(data),.en(en),.Y(Y),.Yn(Yn),.reset(reset));
    initial begin
        
        $dumpfile("tb_st_latch.vcd");
        $dumpvars(0,t_latch);
        reset= 1'b1;
        data = 32'h00000000;
        en = 0;
        #1;
        reset = 1'b0;
        data = 32'h000000A2;
        en = 1;
        #3;

        $finish;
    end
endmodule