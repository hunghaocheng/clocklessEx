`timescale 1ps/1ps
module tb_glitch_probe;
  reg[7:0] memo_type;
  wire[7:0] memo_addr;
  reg valid_memo;
  reg [31:0] tb_flash [0:1023];
  initial $readmemh("STORAGE/flash_memo.hex", tb_flash);
  wire[31:0] memo_data = tb_flash[memo_addr];
  reg reset, ack;
  wire req;
  st_memo_register dut(memo_type, valid_memo, memo_data, memo_addr, ack, req, reset);

  wire en3 = (memo_addr == 8'd3) & dut.flashToBram.memo_valid;
  integer seq;

  // 每一次 addr 变化都打印（含同一时刻内的中间态）
  always @(memo_addr) begin
    seq = seq + 1;
    $display("ADDR_CHG#%0d t=%0t addr=%0d (0b%b) en3=%b req3=%b",
             seq, $time, memo_addr, memo_addr, en3, dut.flashToBram.mula.req_3);
  end

  always @(posedge en3) begin
    $display("EN3_RISE  t=%0t addr=%0d req3=%b", $time, memo_addr, dut.flashToBram.mula.req_3);
  end

  integer i;
  initial begin
    seq = 0;
    reset = 1'b1;
    ack = 1'b0;
    memo_type = 8'h02;
    valid_memo = 1'b0;
    #1;
    reset = 1'b0;
    for (i = 0; i < 4; i = i + 1) begin
      #1;
      $display("--- pulse%0d valid rise ---", i);
      valid_memo = 1'b1;
      #1;
      $display("--- pulse%0d valid fall; settled addr=%0d req3=%b ---",
               i, memo_addr, dut.flashToBram.mula.req_3);
      valid_memo = 1'b0;
      #1;
    end
    $finish;
  end
endmodule
