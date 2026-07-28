// 突触：事务使能 en 与权重 weight 门控，产生局部发放 fire，并透传数据
module st_synapse(
    input[7:0] data_in,
    input en,
    input weight,
    output[7:0] data_out,
    output fire
);
    and g_fire(fire, en, weight);

    and g0(data_out[0], data_in[0], fire);
    and g1(data_out[1], data_in[1], fire);
    and g2(data_out[2], data_in[2], fire);
    and g3(data_out[3], data_in[3], fire);
    and g4(data_out[4], data_in[4], fire);
    and g5(data_out[5], data_in[5], fire);
    and g6(data_out[6], data_in[6], fire);
    and g7(data_out[7], data_in[7], fire);
endmodule
