module st_8_latch(
    input[7:0] data,
    input en,
    output [7:0] Y,
    output[7:0] Yn,
    input reset
);
    st_latch latch0(data[0],en,Y[0],Yn[0],reset);
    st_latch latch1(data[1],en,Y[1],Yn[1],reset);
    st_latch latch2(data[2],en,Y[2],Yn[2],reset);
    st_latch latch3(data[3],en,Y[3],Yn[3],reset);
    st_latch latch4(data[4],en,Y[4],Yn[4],reset);
    st_latch latch5(data[5],en,Y[5],Yn[5],reset);
    st_latch latch6(data[6],en,Y[6],Yn[6],reset);
    st_latch latch7(data[7],en,Y[7],Yn[7],reset);

endmodule