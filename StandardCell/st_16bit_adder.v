module st_16bit_adder(
    input  [15:0] A,
    input  [15:0] B,
    input         Cin,
    output [15:0] S,
    output        Cout
);
    wire [3:0] Gg, Pg;
    wire [4:0] C;

    assign C[0] = Cin;

    assign C[1] = Gg[0] | (Pg[0] & C[0]);
    assign C[2] = Gg[1] | (Pg[1] & Gg[0]) | (Pg[1] & Pg[0] & C[0]);
    assign C[3] = Gg[2] | (Pg[2] & Gg[1]) | (Pg[2] & Pg[1] & Gg[0]) | (Pg[2] & Pg[1] & Pg[0] & C[0]);
    assign C[4] = Gg[3] | (Pg[3] & Gg[2]) | (Pg[3] & Pg[2] & Gg[1]) | (Pg[3] & Pg[2] & Pg[1] & Gg[0]) | (Pg[3] & Pg[2] & Pg[1] & Pg[0] & C[0]);

    st_4bit_adder block0 (.A(A[3:0]),   .B(B[3:0]),   .cin(C[0]), .S(S[3:0]),   .Gg(Gg[0]), .Pg(Pg[0]));
    st_4bit_adder block1 (.A(A[7:4]),   .B(B[7:4]),   .cin(C[1]), .S(S[7:4]),   .Gg(Gg[1]), .Pg(Pg[1]));
    st_4bit_adder block2 (.A(A[11:8]),  .B(B[11:8]),  .cin(C[2]), .S(S[11:8]),  .Gg(Gg[2]), .Pg(Pg[2]));
    st_4bit_adder block3 (.A(A[15:12]), .B(B[15:12]), .cin(C[3]), .S(S[15:12]), .Gg(Gg[3]), .Pg(Pg[3]));

    assign Cout = C[4];
endmodule
