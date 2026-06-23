module st_8bit_adder(
    input [7:0] A,
    input [7:0] B,
    input      cin,
    output [7:0] S,
    output      Cout
);
    wire c_mid;
    st_4bit_adder uut1(.A(A[3:0]),.B(B[3:0]),.cin(cin),.S(S[3:0]),.Cout(c_mid));
    st_4bit_adder uut2(.A(A[7:4]),.B(B[7:4]),.cin(c_mid),.S(S[7:4]),.Cout(Cout));
endmodule