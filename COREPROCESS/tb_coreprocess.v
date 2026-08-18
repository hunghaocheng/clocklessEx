`timescale 1ns/1ns
/* 
    iverilog -o ./COREPROCESS/tb_core.out -c ./COREPROCESS/sources.f 
*/
module tb_coreprocess;
    reg[31:0] device_a, device_b, device_c, device_d, device_e, device_f,
        device_g, device_h, device_i, device_j, device_k, device_l,
        device_m, device_n, device_o, device_p, device_q, device_r, 
        device_s, device_t, device_u, device_v, device_w, device_x, device_y, device_z;

    wire[31:0] token_z;

    wire[7:0] device_out_z,device_out_z_n,device_out_h0,device_out_h1;      
    reg en_z, en_h0,en_h1,ack;
    reg[7:0] type_z,source_id,flags;
    
    wire valid_z,valid_h0,valid_h1;

    // en_z 发送控制信号告诉注册器可以读取信号了  
    // ack 模拟后面时刻 告诉注册器已经处理完数据，可以释放数据了
    st_event_register event_z(.data_in(device_z[7:0]),.en(en_z),.ack(ack),.data_out(device_out_z),.req(valid_z));
    st_event_register event_h0(.data_in(device_h[7:0]),.en(en_h0),.ack(ack),.data_out(device_out_h0),.req(valid_h0));
    st_event_register event_h1(.data_in(device_h[7:0]),.en(en_h1),.ack(ack),.data_out(device_out_h1),.req(valid_h1));
    
    // 事件添加到token包内 token增加额外信息
    st_token_generator token_gen_z(device_out_z,type_z,source_id,flags,token_z,valid_z);

    // 将token分发到不同路由
    st_1_to_4_router router_z(token_z,valid_z,token_out1,token_out2,token_out3,token_out4);

    
    
    initial begin
        device_a = 0; device_b = 0; device_c = 0; device_d = 0; device_e = 0; device_f = 0;
        device_g = 0; device_h = 0; device_i = 0; device_j = 0; device_k = 0; device_l = 0;
        device_m = 0; device_n = 0; device_o = 0; device_p = 0; device_q = 0; device_r = 0;
        device_s = 0; device_t = 0; device_u = 0; device_v = 0; device_w = 0; device_x = 0;
        device_y = 0; device_z = 0;

        type_z = 8'h02;
        source_id = 8'h08;
        flags = 8'h00;
        en_z = 0;
        en_h0 = 0;
        en_h1 = 0;
        ack = 0;
        $dumpfile("tb_core.vcd");
        $dumpvars(0,tb_coreprocess);
        #10;
        device_z = 32'h00000003;
        en_z = 1'b1;
        #5
        en_z = 0;
        #10;
        en_h0 = 1'b1;
        device_h = 32'h00000002;
        #5;
        en_h0 = 0;
        #10;
        en_h1 = 1;
        #5;
        en_h1 = 0;
        #10;
        ack = 1;
        #10;


        // device_h = 32'h00000002;
        //en = 1'b0;
        //#10;
        //device_h = 0;
        //en = 1'b1;
        // device_h = 32'h00000002;
        //en = 1'b0;
    end

endmodule