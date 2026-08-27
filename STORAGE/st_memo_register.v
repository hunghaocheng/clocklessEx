module st_memo_register(
    input wire[7:0] memo_type,
    input wire valid_memo,
    input wire[31:0] memo_data,
    input wire[7:0] memo_acks,
    output wire[7:0] memo_addr
);
    wire do_flashToBRAM = valid_memo && (memo_type == 8'b00000010);
    wire do_BRAMToflash = valid_memo && (memo_type == 8'b00000100);

    wire req_0;
    //wire need_write_0 = do_flashToBRAM && (~req_0);
    wire ack_0 = memo_acks[0];
    st_flash_to_bram flashToBram_0(.memo_data(memo_data),.valid(do_flashToBRAM),.req(req_0),.ack(ack_0));

    wire step_1 = req_0 && ~do_flashToBRAM && ~ack_0;


    wire req_1;
    wire cout_0_to_1; // 看计算结果有没有超过8位
    wire[7:0] addr_now, addr_next,addr_now_n;
    st_8bit_adder adder_0_to_1 (addr_now,8'b00000001,1'b0,addr_next,cout_0_to_1);
    st_8_latch addr_reg(
    .data(addr_next),
    .en(step_1),      // 或 init|step
    .Y(addr_now),
    .Yn(addr_now_n)
);
    assign memo_addr = addr_now;

    wire ack_1 = memo_acks[1];
    st_flash_to_bram flashToBram_1(.memo_data(memo_data),.valid(step_1),.req(req_1),.ack(ack_1));
    
endmodule