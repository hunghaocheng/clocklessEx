module st_c_element(
    input a,
    input b,
    output y
);

    wire n1, n2, n3;
    nand g1(n1, a, y);
    nand g2(n2, b, y);
    nand g3(n3, a, b);
    nand g4(y, n1, n2, n3);
    
endmodule