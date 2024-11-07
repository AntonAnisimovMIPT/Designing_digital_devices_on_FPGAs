module number_converter (
    input wire clk,
    input wire reset, 
    input wire [7:0] switches,  
    input wire convert_button,   
    output reg [7:0] red_leds,   
    output reg overflow_flag,     
    output [6:0] HEX4,           
    output [6:0] HEX5,           
    output [6:0] HEX6,           
    output [6:0] HEX7            
);

    reg convert_r, convert_rr;      
    wire convert_pulse;             

    reg [3:0] hex_lower, hex_upper; 
    reg [3:0] dec_lower, dec_upper; 

    always @(posedge clk) begin
        if (!reset) begin
            red_leds <= 8'b0;
            overflow_flag <= 0;
            hex_lower <= 4'b0;
            hex_upper <= 4'b0;
            dec_lower <= 4'b0;
            dec_upper <= 4'b0;
        end else if (convert_pulse) begin
            red_leds <= switches;

            hex_lower <= switches[3:0];
            hex_upper <= switches[7:4];

            if (switches > 8'd99) begin
                overflow_flag <= 1;
                dec_lower <= 4'd9;
                dec_upper <= 4'd9;
            end else begin
                overflow_flag <= 0;
                dec_lower <= switches % 10;
                dec_upper <= (switches / 10) % 10;
            end
        end
    end

    always @(posedge clk) begin
        convert_r <= convert_button;
        convert_rr <= convert_r;
    end

    assign convert_pulse = !convert_rr && convert_r;

    seven_segment_display hex_display_lower (.hex(hex_lower), .s_seg(HEX4));
    seven_segment_display hex_display_upper (.hex(hex_upper), .s_seg(HEX5));
    seven_segment_display dec_display_lower (.hex(dec_lower), .s_seg(HEX6));
    seven_segment_display dec_display_upper (.hex(dec_upper), .s_seg(HEX7));

endmodule
