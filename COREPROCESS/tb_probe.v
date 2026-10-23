`timescale 1ps/1ps
module tb_probe;
  reg[7:0] memo_type;
  wire[7:0] memo_addr;
  reg valid_memo;
  reg [31:0] tb_flash [0:1023];
  initial $readmemh("STORAGE/flash_memo.hex", tb_flash);
  wire[31:0] memo_data = tb_flash[memo_addr];
  reg reset, ack;
  wire req;
  st_memo_register dut(memo_type, valid_memo, memo_data, memo_addr, ack, req, reset);

  wire r0 = dut.flashToBram.mula.req_0;
  wire r1 = dut.flashToBram.mula.req_1;
  wire r2 = dut.flashToBram.mula.req_2;
  wire r3 = dut.flashToBram.mula.req_3;
  wire r4 = dut.flashToBram.mula.req_4;
  wire r5 = dut.flashToBram.mula.req_5;
  wire r6 = dut.flashToBram.mula.req_6;
  wire r7 = dut.flashToBram.mula.req_7;
  wire en0 = dut.flashToBram.mula._32latch0.en;
  wire en1 = dut.flashToBram.mula._32latch1.en;
  wire en2 = dut.flashToBram.mula._32latch2.en;
  wire en3 = dut.flashToBram.mula._32latch3.en;
  wire en4 = dut.flashToBram.mula._32latch4.en;
  wire step = dut.flashToBram.memo_valid & dut.flashToBram.req;

  integer i;
  initial begin
    $monitor("t=%0t v=%b addr=%0h step=%b en43210=%b%b%b%b%b r43210=%b%b%b%b%b",
             $time, valid_memo, memo_addr, step, en4, en3, en2, en1, en0, r4, r3, r2, r1, r0);
    reset = 1'b1;
    ack = 1'b0;
    memo_type = 8'h02;
    valid_memo = 1'b0;
    #1;
    reset = 1'b0;
    for (i = 0; i < 8; i = i + 1) begin
      #1;
      valid_memo = 1'b1;
      #1;
      valid_memo = 1'b0;
      #1;
    end
    $finish;
  end
endmodule
