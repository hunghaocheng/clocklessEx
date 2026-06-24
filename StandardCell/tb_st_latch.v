`timescale 1ns/1ns
module tb_st_latch;

    reg data, en;
    wire Y, Yn;
    st_latch t_latch(.data(data),.en(en),.Y(Y),.Yn(Yn));
    initial begin
        
        $dumpfile("tb_st_latch.vcd");
        $dumpvars(0,t_latch);
        force t_latch.Y = 0;
        force t_latch.Yn = 0;
        data = 0;
        en = 1;
        #20;

        $finish;
    end
endmodule