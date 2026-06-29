module st_8_latch(
    input[7:0] data,
    input en,
    output [7:0] Y,
    output [7:0] Yn
);

    wire [7:0] r_node ,s_node, inv_data;

    nand  t_nand0(s_node[0], data[0], en);
    nand  t_nand1(s_node[1], data[1], en);
    nand  t_nand2(s_node[2], data[2], en);
    nand  t_nand3(s_node[3], data[3], en);
    nand  t_nand4(s_node[4], data[4], en);
    nand  t_nand5(s_node[5], data[5], en);
    nand  t_nand6(s_node[6], data[6], en);
    nand  t_nand7(s_node[7], data[7], en);


    not  not0(inv_data[0], data[0]);
    not  not1(inv_data[1], data[1]);
    not  not2(inv_data[2], data[2]);
    not  not3(inv_data[3], data[3]);
    not  not4(inv_data[4], data[4]);
    not  not5(inv_data[5], data[5]);
    not  not6(inv_data[6], data[6]);
    not  not7(inv_data[7], data[7]);

    nand  t_nand_2_0(r_node[0], inv_data[0], en);
    nand  t_nand_2_1(r_node[1], inv_data[1], en);
    nand  t_nand_2_2(r_node[2], inv_data[2], en);
    nand  t_nand_2_3(r_node[3], inv_data[3], en);
    nand  t_nand_2_4(r_node[4], inv_data[4], en);
    nand  t_nand_2_5(r_node[5], inv_data[5], en);
    nand  t_nand_2_6(r_node[6], inv_data[6], en);
    nand  t_nand_2_7(r_node[7], inv_data[7], en);


    nand  t_nand_q_0(Y[0],s_node[0],Yn[0]);
    nand  t_nand_q_1(Y[1],s_node[1],Yn[1]);
    nand  t_nand_q_2(Y[2],s_node[2],Yn[2]);
    nand  t_nand_q_3(Y[3],s_node[3],Yn[3]);
    nand  t_nand_q_4(Y[4],s_node[4],Yn[4]);
    nand  t_nand_q_5(Y[5],s_node[5],Yn[5]);
    nand  t_nand_q_6(Y[6],s_node[6],Yn[6]);
    nand  t_nand_q_7(Y[7],s_node[7],Yn[7]);

    nand  t_nand4_q_n_0(Yn[0],r_node[0],Y[0]);
    nand  t_nand4_q_n_1(Yn[1],r_node[1],Y[1]);
    nand  t_nand4_q_n_2(Yn[2],r_node[2],Y[2]);
    nand  t_nand4_q_n_3(Yn[3],r_node[3],Y[3]);
    nand  t_nand4_q_n_4(Yn[4],r_node[4],Y[4]);
    nand  t_nand4_q_n_5(Yn[5],r_node[5],Y[5]);
    nand  t_nand4_q_n_6(Yn[6],r_node[6],Y[6]);
    nand  t_nand4_q_n_7(Yn[7],r_node[7],Y[7]);

endmodule