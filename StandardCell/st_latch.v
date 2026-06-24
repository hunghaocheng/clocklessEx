module st_latch(
    input data,
    input en,
    output Y,
    output Yn
);
    wire r_node ,s_node, inv_data;
    nand #1 t_nand1(s_node, data, en);

    not #1 t_not1(inv_data, data);
    nand #1 t_nand2(r_node, inv_data, en);

    nand #1 t_nand3_q(Y,s_node,Yn);
    nand #1 t_nand4_q_n(Yn,r_node,Y);
endmodule