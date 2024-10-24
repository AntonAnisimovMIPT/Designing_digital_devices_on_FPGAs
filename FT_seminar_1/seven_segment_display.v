module seven_segment_display (
    input [3:0] hex,     
    output [6:0] s_seg      
);

    assign s_seg = 
        
            (hex == 4'h0) ? ~7'b011_1111 :  
            (hex == 4'h1) ? ~7'b000_0110 :
            (hex == 4'h2) ? ~7'b101_1011 :
            (hex == 4'h3) ? ~7'b100_1111 :
            (hex == 4'h4) ? ~7'b110_0110 :
            (hex == 4'h5) ? ~7'b110_1101 :
            (hex == 4'h6) ? ~7'b111_1101 :
            (hex == 4'h7) ? ~7'b000_0111 :
            (hex == 4'h8) ? ~7'b111_1111 :
            (hex == 4'h9) ? ~7'b110_1111 :
            (hex == 4'hA) ? ~7'b111_0111 :
            (hex == 4'hB) ? ~7'b111_1100 :
            (hex == 4'hC) ? ~7'b011_1001 :
            (hex == 4'hD) ? ~7'b101_1110 :
            (hex == 4'hE) ? ~7'b111_1001 :
            (hex == 4'hF) ? ~7'b111_0001 : ~7'b111_1111;
       


endmodule
