module async_to_sync_fifo_ctrl #(
    parameter DATA_WIDTH = 8,
    parameter FIFO_DEPTH = 16,
    parameter ADDR_WIDTH = 4)(
        input wire async_wr_req,
        input wire[DATA_WIDTH-1:0] async_din,

        input wire clk_cache,
        input wire rst_n,
        input wire rd_en,

        output wire [DATA_WIDTH-1:0] dout,
        output wire empty,
        output wire full
    );

    reg [2:0] wr_req_sync;

    always @(posedge clk_cache or negedge rst_n) begin
        if(!rst_n) begin 
            wr_req_sync <= 3'b000;
        end else begin
            wr_req_sync <= {wr_req_sync[1:0], async_wr_req};
        end
    end

    reg [DATA_WIDTH-1:0] din_reg;
    wire wr_en;

    always @(posedge clk_cache or negedge rst_n) begin
        if (!rst_n) begin
            din_reg <= {DATA_WIDTH{1'b0}};
        end else if (async_wr_req) begin
            din_reg <= async_din;
        end
    end

    assign wr_en = (wr_req_sync[1] && !wr_req_sync[2]) && !full;

    reg [DATA_WIDTH-1:0] fifo_ram [FIFO_DEPTH-1:0];
    reg [ADDR_WIDTH:0] wr_ptr;
    reg [ADDR_WIDTH:0] rd_ptr;

    always @(posedge clk_cache or negedge rst_n) begin
        if(!rst_n) begin
            wr_ptr <= 0;
        end else if(wr_en) begin
            fifo_ram[wr_ptr[ADDR_WIDTH-1:0]] <= din_reg;
            wr_ptr <= wr_ptr + 1'b1;
        end
    end


    always @(posedge clk_cache or negedge rst_n) begin
        if(!rst_n) begin
            rd_ptr <= 0;
        end else if (rd_en && !empty) begin
            rd_ptr <= rd_ptr + 1'b1;
        end
    end
    

    assign dout = fifo_ram[rd_ptr[ADDR_WIDTH-1:0]];
    assign empty = (wr_ptr == rd_ptr);
    assign full = (wr_ptr[ADDR_WIDTH] != rd_ptr[ADDR_WIDTH]) &&
    (wr_ptr[ADDR_WIDTH-1:0] == rd_ptr[ADDR_WIDTH-1:0]);

endmodule