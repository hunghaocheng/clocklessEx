module driven(
    input [3:0] signal_1,
    input [3:0] signal_2,
    output [3:0] signal_out);

    wire diff_0, diff_1,diff_2,diff_3 ;
    and signal_and_0 (diff_0, signal_1[0], signal_2[0]);
    and signal_and_1 (diff_1, signal_1[0], signal_2[0]);
    and signal_and_2 (diff_2, signal_1[0], signal_2[0]);
    and signal_and_3 (diff_3, signal_1[0], signal_2[0]);

endmodule