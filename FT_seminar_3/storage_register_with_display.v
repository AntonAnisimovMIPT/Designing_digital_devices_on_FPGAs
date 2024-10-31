module storage_register_with_display (
    input wire clk,              
    input wire reset,            
    input wire [7:0] switches,  
    input wire write_button,    
    input wire transfer_button,   
    output reg [7:0] red_leds,   
    output reg [7:0] green_leds,
    output [6:0] HEX0,           
    output [6:0] HEX1           
);

    reg write_r, write_rr;       
    reg transfer_r, transfer_rr; 
    wire write_pulse;            
    wire transfer_pulse;          

    wire [3:0] lower_nibble = red_leds[3:0];
    wire [3:0] upper_nibble = red_leds[7:4];

    seven_segment_display display0 (.hex(lower_nibble), .s_seg(HEX0));
    seven_segment_display display1 (.hex(upper_nibble), .s_seg(HEX1));

    /* Было
        always @(posedge clk) begin
            if (!reset) begin
                red_leds <= 8'b0;    
                green_leds <= 8'b0;  
            end else begin
                if (write_pulse) begin
                    red_leds <= switches; 
                end
                if (transfer_pulse) begin
                    green_leds <= red_leds;
                end
            end
        end
    */

    // Стало
    always @(posedge clk) begin
        red_leds <= (!reset) ? 8'b0 : (write_pulse ? switches : red_leds);
    end

    always @(posedge clk) begin
        green_leds <= (!reset) ? 8'b0 : (transfer_pulse ? red_leds : green_leds);
    end

    always @(posedge clk) begin
        write_r <= write_button;
        write_rr <= write_r;
    end

    always @(posedge clk) begin
        transfer_r <= transfer_button;
        transfer_rr <= transfer_r;
    end

    assign write_pulse = !write_rr && write_r;      
    assign transfer_pulse = !transfer_rr && transfer_r; 

endmodule
