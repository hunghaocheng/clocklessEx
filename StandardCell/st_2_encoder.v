module st_2_encoder(
    input req,
    output grant_fst,
    output grant_sec
);
    // WIP encoder: req high grants first channel
    wire req_out, req_inv;
    st_latch status(.data(req), .en(1'b1), .Y(req_out), .Yn(req_inv), .reset(1'b0));
    assign grant_fst = req_out;
    assign grant_sec = ~grant_fst;
endmodule
