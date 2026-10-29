`timescale 1ps/1ps
module tb_processing ();
    reg enable, reset;
    wire ring_out;
    wire [2:0] addr_out;
    wire[7:0] memo_addr;
    reg [31:0] tb_flash [0:1023];
    initial $readmemh("STORAGE/flash_memo.hex",tb_flash);
    wire[31:0] memo_data = tb_flash[memo_addr];
    wire[7:0] reqs_out;

    reg ack;
    wire unit_req;
    wire[255:0] datas_out;

    st_ring_osc ring(.enable(enable), .reset(reset), .clk_out(ring_out));
    st_flash_to_bram bram(.memo_data(memo_data),.memo_valid(ring_out),.memo_addr(memo_addr),.ack(ack),.datas_out(datas_out),.reqs_out(reqs_out),.reset(reset));
    st_processing_unit unit(.datas_in(datas_out),.ens(reqs_out),.req_out(unit_req),.reset(reset));

initial begin
        $dumpfile("tb_processing.vcd");
        $dumpvars(0, tb_processing);
        reset = 1'b1;
        enable = 1'b0;
        ack = 1'b0;
        #1;
        reset = 1'b0;
        #1;
        enable = 1'b1;
        #10;
        enable = 1'b0;
        #5;
        enable = 1'b1;
        #20;
        ack = 1'b1;
        #1;
        ack = 1'b0;
        #20;
        ack = 1'b1;
        #1;
        ack = 1'b0;
        #30;
        $finish;
end

endmodule