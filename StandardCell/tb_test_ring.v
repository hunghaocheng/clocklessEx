`timescale 1ps/1ps
module tb_test_ring;
    reg enable, reset;
    wire ring_out;
    wire [2:0] addr_out;

    st_ring_osc ring(.enable(enable), .reset(reset), .clk_out(ring_out));
    //st_3bit_8_stepper hs(.reset(reset), .valid_memo(ring_out), .addr_out(addr_out));
    wire[7:0] memo_addr;
    st_8bit_256_stepper hs(.reset(reset), .valid_memo(ring_out), .addr_out(memo_addr));
    assign addr_out = memo_addr[2:0];
    wire addr_rst = ~addr_out[2] & ~addr_out[1] & ~addr_out[0];
    wire ack = addr_rst & enable;

    initial begin
        $dumpfile("tb_ring.vcd");
        $dumpvars(0, tb_test_ring);
        reset = 1'b1;
        enable = 1'b0;
        #1;
        reset = 1'b0;
        #1;
        enable = 1'b1;
        #20;
        enable = 1'b0;
        #5;
        enable = 1'b1;
        #20;
        $finish;
    end
endmodule
