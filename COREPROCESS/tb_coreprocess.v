`timescale 1ns/1ns
module tb_coreprocess;
    reg[31:0] device_a, device_b, device_c, device_d, device_e, device_f,
        device_g, device_h, device_i, device_j, device_k, device_l,
        device_m, device_n, device_o, device_p, device_q, device_r, 
        device_s, device_t, device_u, device_v, device_w, device_x, device_y, device_z;

    wire[7:0] device_out;      
    st_node node_z(.signal_in(device_z[7:0]),.en(en),.signal_out(device_out));
    reg en;
    initial begin
        device_a = 0; device_b = 0; device_c = 0; device_d = 0; device_e = 0; device_f = 0;
        device_g = 0; device_h = 0; device_i = 0; device_j = 0; device_k = 0; device_l = 0;
        device_m = 0; device_n = 0; device_o = 0; device_p = 0; device_q = 0; device_r = 0;
        device_s = 0; device_t = 0; device_u = 0; device_v = 0; device_w = 0; device_x = 0;
        device_y = 0; device_z = 0;
        en = 0;
        $dumpfile("tb_core.vcd");
        $dumpvars(0,tb_coreprocess);
        #10;
        en = 1'b1;
        device_z = 32'h00000001;
        #1;
        en = 0;
        //en = 1'b0;
        #10;
        // device_z = 32'h00000000;
        //en = 1'b1;
        // device_h = 32'h00000002;
        //en = 1'b0;
        //#10;
        //device_h = 0;
        //en = 1'b1;
        // device_h = 32'h00000002;
        //en = 1'b0;
    end

endmodule