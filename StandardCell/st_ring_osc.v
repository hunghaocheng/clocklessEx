`timescale 1ps/1ps
module st_ring_osc (
    input wire enable,
    input wire reset,
    output wire clk_out
);

    wire n1, n2, n3;
    wire en_n = enable & ~reset;
    // 内部停振预置 1；输出用 en 门控，避免未使能时步进器一直看到高
    assign #1 n1 = en_n ? ~n3 : 1'b1;
    assign #1 n2 = en_n ? ~n1 : 1'b1;
    assign #1 n3 = en_n ? ~n2 : 1'b1;

    assign clk_out = en_n & n3;
endmodule
