module press_event (input wire ext_in,input wire key_in,output wire press_event);
    wire event_in;
    assign event_in = ext_in | key_in;
    assign press_event = ~event_in;

endmodule