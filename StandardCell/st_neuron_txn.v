// 事务驱动无时钟神经元（2 突触）
// 映射：
//   突触事务 en_*     → 生物突触脉冲
//   weight            → 突触是否接通
//   sticky fire latch → 膜电位局部积分（到达记忆）
//   C-element         → 阈值/符合胞体
//   spike req/ack     → 动作电位发放与不应期清除
module st_neuron_txn(
    input[7:0] in_a,
    input[7:0] in_b,
    input en_a,
    input en_b,
    input w_a,
    input w_b,
    input ack,
    output[7:0] spike_data,
    output req
);
    wire fire_a, fire_b;
    wire[7:0] syn_a, syn_b;
    wire stick_a, stick_b, stick_a_n, stick_b_n;
    wire coincide;
    wire[7:0] merge;
    wire[7:0] merge_n;
    wire s_a_n, s_b_n, r_n;
    wire[7:0] hold_a, hold_a_n, hold_b, hold_b_n;
    wire s_inv, r_inv, req_n;

    st_synapse syn0(
        .data_in(in_a),
        .en(en_a),
        .weight(w_a),
        .data_out(syn_a),
        .fire(fire_a)
    );
    st_synapse syn1(
        .data_in(in_b),
        .en(en_b),
        .weight(w_b),
        .data_out(syn_b),
        .fire(fire_b)
    );

    // sticky：fire 置位，ack 清零
    nand g_s_a(s_a_n, fire_a, 1'b1);
    nand g_s_b(s_b_n, fire_b, 1'b1);
    nand g_r(r_n, ack, 1'b1);

    nand g_qa(stick_a, s_a_n, stick_a_n);
    nand g_qan(stick_a_n, r_n, stick_a);
    nand g_qb(stick_b, s_b_n, stick_b_n);
    nand g_qbn(stick_b_n, r_n, stick_b);

    st_c_element soma(.a(stick_a), .b(stick_b), .y(coincide));

    st_8_latch la(.data(syn_a), .en(fire_a), .Y(hold_a), .Yn(hold_a_n));
    st_8_latch lb(.data(syn_b), .en(fire_b), .Y(hold_b), .Yn(hold_b_n));

    or m0(merge[0], hold_a[0], hold_b[0]);
    or m1(merge[1], hold_a[1], hold_b[1]);
    or m2(merge[2], hold_a[2], hold_b[2]);
    or m3(merge[3], hold_a[3], hold_b[3]);
    or m4(merge[4], hold_a[4], hold_b[4]);
    or m5(merge[5], hold_a[5], hold_b[5]);
    or m6(merge[6], hold_a[6], hold_b[6]);
    or m7(merge[7], hold_a[7], hold_b[7]);

    st_8_latch spike_latch(
        .data(merge),
        .en(coincide),
        .Y(spike_data),
        .Yn(merge_n)
    );

    nand(s_inv, coincide, ~ack);
    not(r_inv, ack);
    nand t_q1(req, s_inv, req_n);
    nand t_q2(req_n, r_inv, req);
endmodule
