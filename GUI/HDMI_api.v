module hdmi_api #(
    parameter H_ACTIVE = 1920,
    parameter V_ACTIVE = 1080
) (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [23:0] data,
    output reg         hsync,
    output reg         vsync,
    output reg         de,
    output reg  [7:0]  r,
    output reg  [7:0]  g,
    output reg  [7:0]  b,
    output wire [11:0] pixel_x,
    output wire [11:0] pixel_y
);
    localparam H_FP     = 88;
    localparam H_SYNC   = 44;
    localparam H_BP     = 148;
    localparam H_TOTAL  = 2200;
    localparam V_FP     = 4;
    localparam V_SYNC   = 5;
    localparam V_BP     = 36;
    localparam V_TOTAL  = 1125;

    reg [11:0] hcnt;
    reg [11:0] vcnt;

    assign pixel_x = hcnt;
    assign pixel_y = vcnt;

    wire de_w;
    wire hsync_w;
    wire vsync_w;

    assign de_w = (hcnt < H_ACTIVE) && (vcnt < V_ACTIVE);
    assign hsync_w = ~((hcnt >= H_ACTIVE + H_FP) &&
                       (hcnt <  H_ACTIVE + H_FP + H_SYNC));
    assign vsync_w = ~((vcnt >= V_ACTIVE + V_FP) &&
                       (vcnt <  V_ACTIVE + V_FP + V_SYNC));

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            hcnt <= 12'd0;
            vcnt <= 12'd0;
        end else begin
            if (hcnt == H_TOTAL - 1) begin
                hcnt <= 12'd0;
                if (vcnt == V_TOTAL - 1)
                    vcnt <= 12'd0;
                else
                    vcnt <= vcnt + 12'd1;
            end else begin
                hcnt <= hcnt + 12'd1;
            end
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            hsync <= 1'b1;
            vsync <= 1'b1;
            de    <= 1'b0;
            r     <= 8'd0;
            g     <= 8'd0;
            b     <= 8'd0;
        end else begin
            hsync <= hsync_w;
            vsync <= vsync_w;
            de    <= de_w;
            r     <= data[23:16];
            g     <= data[15:8];
            b     <= data[7:0];
        end
    end
endmodule
