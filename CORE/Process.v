module Process #(
    parameter DATA_WIDTH = 8,
    parameter DATA_DEPTH = 16
)(
    input wire[DATA_WIDTH-1:0] data_in,
    output wire[DATA_WIDTH-1:0] data_out
);
    assign data_out = data_in;
    
endmodule