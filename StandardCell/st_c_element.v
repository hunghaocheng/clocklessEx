module st_c_element(
    input req,
    input ready,
    output load
);

    wire q ,n1, n2;
    nand U1(n1, req, q);
    nand U2(n2, ready, q);
    nand U3(q, n1, n2);

    buf U4(load, q);
endmodule