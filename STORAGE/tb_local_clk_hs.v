`timescale 1ps/1ps
module tb_local_clk_hs;
    reg reset, step_req;
    reg[7:0] addr_a, addr_b, addr_next;
    wire en_a, en_b, busy;
    st_local_clk_hs clk(reset,step_req,addr_a,addr_b, addr_next, en_a, en_b, busy);

    initial begin
    $dumpfile("tb_clk.vcd");
    $dumpvars(0,tb_local_clk_hs);
    reset = 1'b1;
    step_req = 1'b0;
    addr_a = 8'b00000000;
    addr_b = 8'b00000000;
    addr_next = 8'b00001000;
    #2;
    reset = 1'b0;

    #3;
    step_req = 1'b1;
    #5;
    step_req = 1'b0;
    #5;
    step_req = 1'b1;
    #1;
    step_req = 1'b0;
    #5;

    step_req = 1'b1;
    #1;
    step_req = 1'b0;
    #1;
    step_req = 1'b1;
    #1;
    step_req = 1'b0;
    #10;
    $finish;
    end

endmodule