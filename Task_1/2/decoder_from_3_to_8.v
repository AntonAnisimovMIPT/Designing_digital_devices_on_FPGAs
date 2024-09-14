module decoder_from_3_to_8 (
    input [2:0] N,       
    output wire [7:0] result   
);

    assign result = 8'b00000001 << N;

endmodule
