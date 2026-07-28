`timescale 1ns/1ns
module tb_st_neuron_txn;
    reg[7:0] in_a, in_b;
    reg en_a, en_b, w_a, w_b, ack;
    wire[7:0] spike_data;
    wire req;

    st_neuron_txn uut(
        .in_a(in_a),
        .in_b(in_b),
        .en_a(en_a),
        .en_b(en_b),
        .w_a(w_a),
        .w_b(w_b),
        .ack(ack),
        .spike_data(spike_data),
        .req(req)
    );

    initial begin
        $dumpfile("tb_st_neuron_txn.vcd");
        $dumpvars(0, tb_st_neuron_txn);

        in_a = 0; in_b = 0;
        en_a = 0; en_b = 0;
        w_a = 1; w_b = 1;
        ack = 0;

        // 事件 z=7A，随后 h=68（不同相），应在两路都到后发放
        #10;
        in_a = 8'h7A;
        en_a = 1;
        #5;
        en_a = 0;
        #10;
        in_b = 8'h68;
        en_b = 1;
        #5;
        en_b = 0;
        #10;
        $display("after both synapses: req=%b spike=%h", req, spike_data);

        // ack 清除
        ack = 1;
        #10;
        ack = 0;
        #10;
        $display("after ack: req=%b spike=%h", req, spike_data);

        // 权重断开 B：仅 A 到，不应发放新 req（coincide 需两路）
        in_a = 8'h79; // y
        in_b = 8'h6B; // k
        w_b = 0;
        en_a = 1;
        #5; en_a = 0;
        #5;
        en_b = 1;
        #5; en_b = 0;
        #10;
        $display("weight_b=0: req=%b spike=%h", req, spike_data);

        #20;
        $finish;
    end
endmodule
