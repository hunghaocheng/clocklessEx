`timescale 1ps/1ps


module tb_async_to_sync_fifo;

    parameter DATA_WIDTH = 8;
    parameter FIFO_DEPTH = 4;
    parameter ADDR_WIDTH = 2;

    reg async_wr_req;
    reg [DATA_WIDTH-1:0] async_din;
    reg clk_cache;
    reg rst_n;
    reg rd_en;

    wire [DATA_WIDTH-1:0] dout;
    wire empty;
    wire full;

    async_to_sync_fifo_ctrl #(
        .DATA_WIDTH(DATA_WIDTH),
        .FIFO_DEPTH(FIFO_DEPTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .async_wr_req(async_wr_req),
        .async_din(async_din),
        .clk_cache(clk_cache),
        .rst_n(rst_n),
        .rd_en(rd_en),
        .dout(dout),
        .empty(empty),
        .full(full)
    );

    always #5000 clk_cache = ~clk_cache;
    integer idx;
    initial begin
        $dumpfile("tb_FIFO_cache.vcd");
        $dumpvars(0, uut);
        for (idx = 0; idx < FIFO_DEPTH; idx = idx + 1)
            $dumpvars(0, uut.fifo_ram[idx]);
        clk_cache = 0;
        rst_n = 0;
        async_wr_req = 0;
        async_din = 0;
        rd_en = 0;

        #20000;
        rst_n = 1;
        #10000;

        //#9995;
        async_din = 8'hAA;
        async_wr_req = 1;
        $display("[%0t ps] >> 5bit written successfully", $time);
        #20000;

        async_wr_req = 0;
        #10000;

        $display("[%0t ps] >> 5ps", $time);
/*
        #20000;
        $display("[%0t ps] >> 20000ps", $time);

        begin: write_loop
            integer i;
            for(i = 1; i <= 16; i = i + 1) begin
                #23500;
                async_din = i;
                async_wr_req = 1;
                #16500;
                async_wr_req = 0;
            end
        end

        #20000;
        $display("[%0t ps] >> 16 bit finished writing", $time);
        $display(" wr_ptr = 5'b%b", uut.wr_ptr);
        $display("rd_ptr = 5'b%b", uut.rd_ptr);
        $display("Empty: %b, Full: %b", empty, full);

        #10000;
        async_din = 8'hBB;
        async_wr_req = 1;
        #20000;
        async_wr_req = 0;
        if(uut.fifo_ram[0] == 8'h01) begin
            $display("[%0t ps] >> 1st data read successfully", $time);
        end

        #10000;
        @(posedge clk_cache);
        rd_en = 1;
        $display("[%0t ps] >> rd_en = 1", $time);
        repeat(18) begin
            @(posedge clk_cache);
            #100;
            $display("dout = 8'h%h ,Empty = %b",dout, empty);
        end

        #50000;
        $display("[%0t ps] CDC reset", $time);
*/
        $finish;

    end
endmodule