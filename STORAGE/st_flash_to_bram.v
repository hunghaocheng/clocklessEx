`timescale 1ps/1ps
module st_flash_to_bram(
    input wire[31:0] memo_data,
    input wire memo_valid,
    output wire[7:0] memo_addr,
    input wire ack,
    output wire[7:0] reqs_out,
    input wire reset
);
    wire req = reqs_out[0] | reqs_out[1] | reqs_out[2] | reqs_out[3] | reqs_out[4] | reqs_out[5] | reqs_out[6] | reqs_out[7];
    wire valid = memo_valid & req;


    st_8bit_256_stepper u_hs(reset, ~memo_valid & ~all_full, memo_addr);
    st_mula_bram mula(memo_data, memo_valid & ~all_full , memo_addr, ack, reqs_out, reset);
    wire all_full = reqs_out[0] & reqs_out[1] & reqs_out[2] & reqs_out[3] & reqs_out[4] & reqs_out[5] & reqs_out[6] & reqs_out[7];
endmodule