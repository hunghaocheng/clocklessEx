`timescale 1ns/1ns
module tb_st_half_adder;
    reg A, B;
    wire S, C;
    st_half_adder uut(.A(A),.B(B),.S(S),.C(C));
    reg [2:0] i;
    initial begin
        $dumpfile("tb_st_half_adder.vcd");
        $dumpvars(0,tb_st_half_adder);

        A = 1;
        B = 1;
        #10;

        i = {A, B};
        #10;

        $finish;
    end
endmodule