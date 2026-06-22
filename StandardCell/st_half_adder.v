module st_half_adder(
    input A,
    input B,
    output S,
    output C
);

    xor t_xor1(S, A, B);
    and t_and1(C, A, B);
endmodule