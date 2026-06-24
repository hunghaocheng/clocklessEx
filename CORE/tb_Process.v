`timescale 1ns/1ns
module tb_Process;

    reg[7:0] data_in;
    wire[7:0] data_out;

    Process cess(
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        $dumpfile("tb_Process.vcd");
        $dumpvars(0, tb_Process);
        #10;
        
        assign data_in = 8'h08;
        #10;
        $finish;
    end

endmodule