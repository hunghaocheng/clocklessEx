module st_3_latch(
    input  [2:0] data,
    input        en,
    output [2:0] Y,
    output [2:0] Yn,
    input        reset
);
    st_latch latch0(data[0], en, Y[0], Yn[0], reset);
    st_latch latch1(data[1], en, Y[1], Yn[1], reset);
    st_latch latch2(data[2], en, Y[2], Yn[2], reset);
endmodule
