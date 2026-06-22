module st_mutex(
    input A,
    input B,
    output out_A,
    output out_B
);
//  A get the priority to output first
    wire last_A, last_B,not_B,not_last_A;
    not t_not1(not_B, B);
    and t_and1(last_A, A, not_B);

    not t_not2(not_last_A, last_A);
    and t_and2(last_B, B, not_last_A);

    out_A = last_A;
    out_B = last_B;
endmodule
