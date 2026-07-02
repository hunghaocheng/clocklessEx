module st_32_latch(
    input [31:0] data,
    input en,
    output [31:0] Y,
    output [31:0] Yn
);

    st_latch latch0(data[0],en,Y[0],Yn[0]);
    st_latch latch1(data[1],en,Y[1],Yn[1]);
    st_latch latch2(data[2],en,Y[2],Yn[2]);
    st_latch latch3(data[3],en,Y[3],Yn[3]);
    st_latch latch4(data[4],en,Y[4],Yn[4]);
    st_latch latch5(data[5],en,Y[5],Yn[5]);
    st_latch latch6(data[6],en,Y[6],Yn[6]);
    st_latch latch7(data[7],en,Y[7],Yn[7]);
    st_latch latch8(data[8],en,Y[8],Yn[8]);
    st_latch latch9(data[9],en,Y[9],Yn[9]);
    st_latch latch10(data[10],en,Y[10],Yn[10]);
    st_latch latch11(data[11],en,Y[11],Yn[11]);
    st_latch latch12(data[12],en,Y[12],Yn[12]);
    st_latch latch13(data[13],en,Y[13],Yn[13]);
    st_latch latch14(data[14],en,Y[14],Yn[14]);
    st_latch latch15(data[15],en,Y[15],Yn[15]);
    st_latch latch16(data[16],en,Y[16],Yn[16]);
    st_latch latch17(data[17],en,Y[17],Yn[17]);
    st_latch latch18(data[18],en,Y[18],Yn[18]);
    st_latch latch19(data[19],en,Y[19],Yn[19]);
    st_latch latch20(data[20],en,Y[20],Yn[20]);
    st_latch latch21(data[21],en,Y[21],Yn[21]);
    st_latch latch22(data[22],en,Y[22],Yn[22]);
    st_latch latch23(data[23],en,Y[23],Yn[23]);
    st_latch latch24(data[24],en,Y[24],Yn[24]);
    st_latch latch25(data[25],en,Y[25],Yn[25]);
    st_latch latch26(data[26],en,Y[26],Yn[26]);
    st_latch latch27(data[27],en,Y[27],Yn[27]);
    st_latch latch28(data[28],en,Y[28],Yn[28]);
    st_latch latch29(data[29],en,Y[29],Yn[29]);
    st_latch latch30(data[30],en,Y[30],Yn[30]);
    st_latch latch31(data[31],en,Y[31],Yn[31]);

endmodule