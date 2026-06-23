`timescale 1ns/1ns
module tb_st_16bit_adder;
    reg [15:0] A, B;

    reg Cin;
    wire [15:0] S;
    wire Cout;


    st_16bit_adder uut(.A(A),.B(B),.Cin(Cin),.S(S),.Cout(Cout));
    initial begin
        $dumpfile("tb_st_16bit_adder.vcd");
        $dumpvars(0,tb_st_16bit_adder);
        #10;
        A = 16'h0000;
        B = 16'h0000;
        Cin = 1;
        #10;
        A = 16'h0001;
        B = 16'h0001;
        #10;
        $finish;
    end

endmodule