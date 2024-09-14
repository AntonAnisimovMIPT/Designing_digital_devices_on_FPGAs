module priority_decoder_from_3_to_8 (
    input [7:0] num,      
    output [2:0] wire result      
);

assign result = (
            num[7] ? 3'd7 :
            num[6] ? 3'd6 :
            num[5] ? 3'd5 :
            num[4] ? 3'd4 :
            num[3] ? 3'd3 :
            num[2] ? 3'd2 :
            num[1] ? 3'd1 : 3'd0);

endmodule
