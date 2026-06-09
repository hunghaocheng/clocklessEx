module ddr3_frame #(
    parameter FRAME_W     = 1920,
    parameter FRAME_H     = 1080,
    parameter FRAME0_BASE = 32'h0000_0000,
    parameter FRAME1_BASE = 32'h0080_0000
) (
    input  wire        pix_clk,
    input  wire        mem_clk,
    input  wire        rst_n,
    input  wire        ddr_ready,
    input  wire        frame_swap,

    input  wire [11:0] pixel_x,
    input  wire [11:0] pixel_y,
    input  wire        scan_de,

    input  wire        wr_req,
    input  wire [11:0] wr_x,
    input  wire [11:0] wr_y,
    input  wire [23:0] wr_data,
    output reg         wr_ready,

    output wire [31:0] display_base,
    output wire [31:0] draw_base,

    output reg         mem_arvalid,
    input  wire        mem_arready,
    output reg  [27:0] mem_araddr,
    output reg  [7:0]  mem_arlen,

    input  wire        mem_rvalid,
    output reg         mem_rready,
    input  wire [31:0] mem_rdata,

    output reg         mem_awvalid,
    input  wire        mem_awready,
    output reg  [27:0] mem_awaddr,
    output reg  [3:0]  mem_wstrb,

    output reg         mem_wvalid,
    input  wire        mem_wready,
    output reg  [31:0] mem_wdata,

    input  wire        mem_bvalid,
    output reg         mem_bready,

    output reg  [23:0] pixel_data
);
    localparam BURST_MAX = 256;

    reg [23:0] line_buf [0:FRAME_W-1];

    reg [31:0] display_base_reg;
    reg [31:0] draw_base_reg;

    assign display_base = display_base_reg;
    assign draw_base    = draw_base_reg;

    reg [1:0]  rstate;
    reg [11:0] wr_x_cnt;
    reg [11:0] words_left;
    reg [27:0] ar_addr;
    reg [11:0] active_y;
    reg        line_ready;
    reg [7:0]  beat_total;
    reg [7:0]  beat_cnt;

    reg [1:0]  wstate;
    reg [11:0] wr_x_lat;
    reg [11:0] wr_y_lat;
    reg [23:0] wr_data_lat;

    reg [11:0] active_y_meta;
    reg [11:0] active_y_pix;
    reg        line_ready_meta;
    reg        line_ready_pix;
    reg        line_done_pix;
    reg        line_done_sync1;
    reg        line_done_sync2;
    reg        frame_swap_sync1;
    reg        frame_swap_sync2;
    reg        frame_swap_sync2_d;
    reg        frame_swap_mem;

    function automatic [27:0] line_start_addr(input [31:0] base, input [11:0] y);
        line_start_addr = base[27:0] + ((y * FRAME_W) << 2);
    endfunction

    function automatic [27:0] pixel_addr(
        input [31:0] base,
        input [11:0] x,
        input [11:0] y
    );
        pixel_addr = base[27:0] + (((y * FRAME_W) + x) << 2);
    endfunction

    always @(posedge mem_clk or negedge rst_n) begin
        if (!rst_n) begin
            display_base_reg <= FRAME0_BASE;
            draw_base_reg    <= FRAME1_BASE;
        end else if (frame_swap_mem) begin
            display_base_reg <= draw_base_reg;
            draw_base_reg    <= display_base_reg;
        end
    end

    always @(posedge mem_clk or negedge rst_n) begin
        if (!rst_n) begin
            frame_swap_sync1   <= 1'b0;
            frame_swap_sync2   <= 1'b0;
            frame_swap_sync2_d <= 1'b0;
            frame_swap_mem     <= 1'b0;
        end else begin
            frame_swap_sync1   <= frame_swap;
            frame_swap_sync2   <= frame_swap_sync1;
            frame_swap_mem     <= frame_swap_sync2 && !frame_swap_sync2_d;
            frame_swap_sync2_d <= frame_swap_sync2;
        end
    end

    always @(posedge mem_clk or negedge rst_n) begin
        if (!rst_n) begin
            rstate      <= 2'd0;
            mem_arvalid <= 1'b0;
            mem_araddr  <= 28'd0;
            mem_arlen   <= 8'd0;
            mem_rready  <= 1'b0;
            wr_x_cnt    <= 12'd0;
            words_left  <= 12'd0;
            ar_addr     <= 28'd0;
            active_y    <= 12'd0;
            line_ready  <= 1'b0;
            beat_total  <= 8'd0;
            beat_cnt    <= 8'd0;
        end else if (!ddr_ready) begin
            rstate      <= 2'd0;
            mem_arvalid <= 1'b0;
            mem_rready  <= 1'b0;
            line_ready  <= 1'b0;
        end else begin
            if (line_done_sync2) begin
                line_ready <= 1'b0;
                if (active_y == FRAME_H - 1)
                    active_y <= 12'd0;
                else
                    active_y <= active_y + 12'd1;
            end

            case (rstate)
                2'd0: begin
                    mem_rready <= 1'b0;
                    if (!line_ready) begin
                        words_left <= FRAME_W;
                        wr_x_cnt   <= 12'd0;
                        ar_addr    <= line_start_addr(display_base_reg, active_y);
                        rstate     <= 2'd1;
                    end
                end

                2'd1: begin
                    if (!mem_arvalid) begin
                        if (words_left > BURST_MAX) begin
                            mem_arlen   <= 8'd255;
                            beat_total  <= 8'd255;
                            words_left  <= words_left - BURST_MAX;
                        end else if (words_left != 0) begin
                            mem_arlen   <= words_left[7:0] - 8'd1;
                            beat_total  <= words_left[7:0] - 8'd1;
                            words_left  <= 12'd0;
                        end
                        mem_araddr  <= ar_addr;
                        mem_arvalid <= 1'b1;
                        beat_cnt    <= 8'd0;
                    end
                    if (mem_arvalid && mem_arready) begin
                        mem_arvalid <= 1'b0;
                        ar_addr     <= ar_addr + ((mem_arlen + 8'd1) << 2);
                        rstate      <= 2'd2;
                        mem_rready  <= 1'b1;
                    end
                end

                2'd2: begin
                    if (mem_rvalid && mem_rready) begin
                        line_buf[wr_x_cnt] <= mem_rdata[23:0];
                        wr_x_cnt           <= wr_x_cnt + 12'd1;
                        beat_cnt           <= beat_cnt + 8'd1;
                        if (beat_cnt == beat_total) begin
                            mem_rready <= 1'b0;
                            if (wr_x_cnt == FRAME_W - 1)
                                line_ready <= 1'b1;
                            if (words_left == 0 && wr_x_cnt == FRAME_W - 1)
                                rstate <= 2'd0;
                            else
                                rstate <= 2'd1;
                        end
                    end
                end

                default: rstate <= 2'd0;
            endcase
        end
    end

    always @(posedge mem_clk or negedge rst_n) begin
        if (!rst_n) begin
            wstate      <= 2'd0;
            mem_awvalid <= 1'b0;
            mem_awaddr  <= 28'd0;
            mem_wstrb   <= 4'b1111;
            mem_wvalid  <= 1'b0;
            mem_wdata   <= 32'd0;
            mem_bready  <= 1'b0;
            wr_ready    <= 1'b1;
            wr_x_lat    <= 12'd0;
            wr_y_lat    <= 12'd0;
            wr_data_lat <= 24'd0;
        end else begin
            case (wstate)
                2'd0: begin
                    mem_awvalid <= 1'b0;
                    mem_wvalid  <= 1'b0;
                    mem_bready  <= 1'b0;
                    wr_ready    <= 1'b1;
                    if (wr_req && wr_ready) begin
                        wr_x_lat    <= wr_x;
                        wr_y_lat    <= wr_y;
                        wr_data_lat <= wr_data;
                        mem_awaddr  <= pixel_addr(draw_base_reg, wr_x, wr_y);
                        mem_wdata   <= {8'h0, wr_data};
                        wr_ready    <= 1'b0;
                        wstate      <= 2'd1;
                    end
                end

                2'd1: begin
                    mem_awvalid <= 1'b1;
                    mem_wvalid  <= 1'b1;
                    mem_bready  <= 1'b1;
                    if (mem_awvalid && mem_awready)
                        mem_awvalid <= 1'b0;
                    if (mem_wvalid && mem_wready)
                        mem_wvalid <= 1'b0;
                    if (mem_bvalid && mem_bready)
                        wstate <= 2'd0;
                end

                default: wstate <= 2'd0;
            endcase
        end
    end

    always @(posedge pix_clk or negedge rst_n) begin
        if (!rst_n) begin
            pixel_data      <= 24'd0;
            active_y_meta   <= 12'd0;
            active_y_pix    <= 12'd0;
            line_ready_meta <= 1'b0;
            line_ready_pix  <= 1'b0;
            line_done_pix   <= 1'b0;
            line_done_sync1 <= 1'b0;
            line_done_sync2 <= 1'b0;
        end else begin
            line_done_pix   <= 1'b0;
            line_done_sync1 <= line_done_pix;
            line_done_sync2 <= line_done_sync1;
            active_y_meta   <= active_y;
            active_y_pix    <= active_y_meta;
            line_ready_meta <= line_ready;
            line_ready_pix  <= line_ready_meta;

            if (scan_de && line_ready_pix && (pixel_y == active_y_pix))
                pixel_data <= line_buf[pixel_x];
            else
                pixel_data <= 24'd0;

            if (scan_de && (pixel_x == FRAME_W - 1) && (pixel_y == active_y_pix))
                line_done_pix <= 1'b1;
        end
    end
endmodule
