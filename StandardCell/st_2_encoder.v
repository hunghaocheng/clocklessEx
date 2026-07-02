module st_2_encoder(
    input req,
    output grant_fst,
    output grant_sec
);
    
    // req_fst     req_sec      grant_fst      grant_sec; 
    //    1            1            1              0
    //    1            0            1              0
    //    0            1            0              1
    //    0            0            0              0     
    reg  req_out, req_inv;
    st_latch status(req,0'b1,req_out, req_inv);
    grant_fst = req;
    grant_sec = ~grant_fst & grant_sec;


endmodule