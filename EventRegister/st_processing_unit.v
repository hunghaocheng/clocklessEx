`timescale 1ps/1ps
// 现今指令集到操作系统的操作本质上是把固定或者有限组合的结果复现出来，不是针对最终意图
// 就如sorry, sry, 抱歉 对不起 甚至一个表情 ( >...< )  可以代表一个意图 
module st_processing_unit (
    input wire[255:0] datas_in,
    input wire[7:0] ens,
    output wire req_out,
    input wire reset
);
    wire [7:0] ack;
    assign ack = 8'b00000000;
    wire[7:0] reqs_out;

    assign req_out = reqs_out[0] & reqs_out[1] & reqs_out[2] & reqs_out[3] & reqs_out[4] & reqs_out[5] & reqs_out[6] & reqs_out[7];
    wire[31:0] data_out_a, data_out_b, data_out_c, data_out_d, data_out_e, data_out_f, data_out_g, data_out_h;
    st_32_2ske_latch a(.data_in(datas_in[31:0]),.en(ens[0] & ~reqs_out[0]),.ack(ack[0]),.data_out(data_out_a),.req(reqs_out[0]),.reset(reset));
    st_32_2ske_latch b(.data_in(datas_in[63:32]),.en(ens[1] & ~reqs_out[1]),.ack(ack[1]),.data_out(data_out_b),.req(reqs_out[1]),.reset(reset));
    st_32_2ske_latch c(.data_in(datas_in[95:64]),.en(ens[2] & ~reqs_out[2]),.ack(ack[2]),.data_out(data_out_c),.req(reqs_out[2]),.reset(reset));
    st_32_2ske_latch d(.data_in(datas_in[127:96]),.en(ens[3] & ~reqs_out[3]),.ack(ack[3]),.data_out(data_out_d),.req(reqs_out[3]),.reset(reset));
    st_32_2ske_latch e(.data_in(datas_in[159:128]),.en(ens[4] & ~reqs_out[4]),.ack(ack[4]),.data_out(data_out_e),.req(reqs_out[4]),.reset(reset));
    st_32_2ske_latch f(.data_in(datas_in[191:160]),.en(ens[5] & ~reqs_out[5]),.ack(ack[5]),.data_out(data_out_f),.req(reqs_out[5]),.reset(reset));
    st_32_2ske_latch g(.data_in(datas_in[223:192]),.en(ens[6] & ~reqs_out[6]),.ack(ack[6]),.data_out(data_out_g),.req(reqs_out[6]),.reset(reset));
    st_32_2ske_latch h(.data_in(datas_in[255:224]),.en(ens[7] & ~reqs_out[7]),.ack(ack[7]),.data_out(data_out_h),.req(reqs_out[7]),.reset(reset));

    wire[31:0] states_in;
    assign states_in = 8'h00004000;
    wire[31:0] formula;
    wire[7:0] converge_out, pending_out, diverge_out;
    st_cross_a a_formula(.data_in(data_out_a),.en(reqs_out[0]),.converge_out(converge_out),pending_out(pending_out),diverge_out(diverge_out),.reset(reset));


endmodule