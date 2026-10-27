`timescale 1ps/1ps
module tb_storage;

    initial begin
        $dumpfile("tb_core.vcd");
        $dumpvars(0,tb_storage);

        $finish;
    end
endmodule