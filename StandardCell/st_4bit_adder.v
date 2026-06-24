module st_4bit_adder(
    input  [3:0] A,
    input  [3:0] B,
    input         cin,
    output [3:0] S,
    output        Cout,
    output        Gg,
    output        Pg
);
    wire [3:0] P, G;
    wire [4:0] C;

    assign C[0] = cin;
    assign G = A & B;
    assign P = A ^ B;

    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & G[0]) | (P[1] & P[0] & C[0]);
    assign C[3] = G[2] | (P[2] & G[1]) | (P[2] & P[1] & G[0]) | (P[2] & P[1] & P[0] & C[0]);
    assign C[4] = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]) | (P[3] & P[2] & P[1] & P[0] & C[0]);

    assign S = P ^ C[3:0];
    assign Cout = C[4];
    assign Gg = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);
    assign Pg = P[3] & P[2] & P[1] & P[0];
endmodule
