module st_latch(
    input data,
    input en,
    output Y,
    output Yn,
    input reset
);
    wire data_eff = reset ? 1'b0 : data;
    wire en_eff = reset | en;


    wire r_node ,s_node, inv_data;
    nand t_nand1(s_node, data_eff, en_eff);

    not t_not1(inv_data, data_eff);
    nand  t_nand2(r_node, inv_data, en_eff);

    nand  t_nand3_q(Y,s_node,Yn);
    nand t_nand4_q_n(Yn,r_node,Y);


endmodule