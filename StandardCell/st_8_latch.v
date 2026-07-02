module st_8_latch(
    input[7:0] data,
    input en,
    output [7:0] Y,
    output valid
);
    wire valid0,valid1,valid2,valid3,valid4,valid5,valid6,valid7;
    st_latch latch0(data[0],en,Y[0],valid0);
    st_latch latch1(data[1],en,Y[1],valid1);
    st_latch latch2(data[2],en,Y[2],valid2);
    st_latch latch3(data[3],en,Y[3],valid3);
    st_latch latch4(data[4],en,Y[4],valid4);
    st_latch latch5(data[5],en,Y[5],valid5);
    st_latch latch6(data[6],en,Y[6],valid6);
    st_latch latch7(data[7],en,Y[7],valid7);
    and t_and1(valid, valid0, valid1, valid2, valid3, valid4, valid5, valid6, valid7);

endmodule