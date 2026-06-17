module st_full_adder (
    input A,
    input B,
    input Cin,
    output S,
    output Cout
);
    wire w1, w2, w3;
    xor t_xor1(w1, A, B);
    and t_and1(w2, A, B);

    xor t_xor2(S, w1, Cin);
    and t_and2(w3, w1, Cin);

    or t_or(Cout, w2, w3);

endmodule
