module st_latch(
    input data,
    input en,
    output Y,
    output Yn
);
    wire r_node ,s_node, inv_data;
    nand t_nand1(s_node, data, en);

    not t_not1(inv_data, data);
    nand  t_nand2(r_node, inv_data, en);

    nand  t_nand3_q(Y,s_node,Yn);
    nand t_nand4_q_n(Yn,r_node,Y);


    // 想办法记录req

endmodule