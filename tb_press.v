`timescale 1ns/1ns

module tb_press;
    reg ext_in , key_in;
    wire press_event;

    press_event uutp(.ext_in(ext_in),.key_in(key_in),.press_event(press_event));
    initial begin
        $dumpfile("tb_press.vcd");
        $dumpvars(0,uutp);
        ext_in = 0;
        key_in = 0;
        #10;

        ext_in = 1;
        key_in = 0;
        #10;
        ext_in = 0;
        key_in = 1;
        #10;
        $finish;
    end
endmodule