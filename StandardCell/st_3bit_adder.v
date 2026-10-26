module st_3bit_adder(
    input  [2:0] A,
    input  [2:0] B,
    input        cin,
    output [2:0] S,
    output       Cout
);
    wire c0, c1;
    st_full_adder fa0(.A(A[0]), .B(B[0]), .Cin(cin), .S(S[0]), .Cout(c0));
    st_full_adder fa1(.A(A[1]), .B(B[1]), .Cin(c0),  .S(S[1]), .Cout(c1));
    st_full_adder fa2(.A(A[2]), .B(B[2]), .Cin(c1),  .S(S[2]), .Cout(Cout));
endmodule
