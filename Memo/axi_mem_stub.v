module axi_mem_stub #(
    parameter MEM_WORDS = 65536
) (
    input  wire        clk,
    input  wire        rst_n,

    input  wire        arvalid,
    output reg         arready,
    input  wire [27:0] araddr,
    input  wire [7:0]  arlen,

    output reg         rvalid,
    input  wire        rready,
    output reg  [31:0] rdata,

    input  wire        awvalid,
    output reg         awready,
    input  wire [27:0] awaddr,

    input  wire        wvalid,
    output reg         wready,
    input  wire [31:0] wdata,
    input  wire [3:0]  wstrb,

    output reg         bvalid,
    input  wire        bready
);
    reg [31:0] mem [0:MEM_WORDS-1];

    reg        rd_active;
    reg [27:0] rd_addr;
    reg [7:0]  rd_beats_left;

    function automatic [31:0] word_index(input [27:0] byte_addr);
        word_index = byte_addr[31:2] % MEM_WORDS;
    endfunction

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            arready      <= 1'b1;
            awready      <= 1'b1;
            wready       <= 1'b1;
            rvalid       <= 1'b0;
            bvalid       <= 1'b0;
            rd_active    <= 1'b0;
            rd_beats_left<= 8'd0;
        end else begin
            if (arvalid && arready && !rd_active) begin
                rd_active     <= 1'b1;
                rd_addr       <= araddr;
                rd_beats_left <= arlen + 8'd1;
                rvalid        <= 1'b1;
                rdata         <= mem[word_index(araddr)];
            end else if (rd_active && rvalid && rready) begin
                if (rd_beats_left == 8'd1) begin
                    rd_active     <= 1'b0;
                    rvalid        <= 1'b0;
                    rd_beats_left <= 8'd0;
                end else begin
                    rd_addr       <= rd_addr + 28'd4;
                    rd_beats_left <= rd_beats_left - 8'd1;
                    rdata         <= mem[word_index(rd_addr + 28'd4)];
                end
            end

            if (awvalid && awready && wvalid && wready) begin
                if (wstrb[0]) mem[word_index(awaddr)][7:0]   <= wdata[7:0];
                if (wstrb[1]) mem[word_index(awaddr)][15:8]  <= wdata[15:8];
                if (wstrb[2]) mem[word_index(awaddr)][23:16] <= wdata[23:16];
                if (wstrb[3]) mem[word_index(awaddr)][31:24] <= wdata[31:24];
                bvalid <= 1'b1;
            end

            if (bvalid && bready)
                bvalid <= 1'b0;
        end
    end
endmodule
