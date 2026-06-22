module st_c_element(
    input A,
    input B,
    output Y
);
// Y = (A & B) | (Y & (A | B));
    wire w1, w2, w3;

    or t_or1(w1, A, B);
    and t_and1(w2, Y, w1);

    and t_and2(w3, A, B);

    or t_or2(Y, w2, w3);

endmodule