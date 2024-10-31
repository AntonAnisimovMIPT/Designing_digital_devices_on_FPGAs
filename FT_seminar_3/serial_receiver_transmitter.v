module serial_receiver_transmitter (
    input wire clk,                 
    input wire reset,               
    input wire [7:0] switches,      
    input wire write_button,        
    input wire transfer_button,     
    input wire shift_value,         
    output reg [7:0] red_leds,      
    output reg [7:0] green_leds     
);

    reg write_r, write_rr;          
    reg transfer_r, transfer_rr;    
    wire write_pulse;               
    wire transfer_pulse;            

    always @(posedge clk) begin
        if (!reset) begin
            red_leds <= 8'b0;       
            green_leds <= 8'b0;     
        end else begin
            if (write_pulse) begin
                red_leds <= switches; 
            end
            if (transfer_pulse) begin
                green_leds <= {red_leds[0], green_leds[7:1]};  // младший бит красных -> старший бит зеленых
                red_leds <= {shift_value, red_leds[7:1]};       // сдвиг вправо красных, вдвигаем shift_value
            end
        end
    end

    always @(posedge clk) begin
        write_r <= write_button;
        write_rr <= write_r;
    end

    always @(posedge clk) begin
        transfer_r <= transfer_button;
        transfer_rr <= transfer_r;
    end

    assign write_pulse = write_rr && !write_r;        
    assign transfer_pulse = transfer_rr && !transfer_r; 

endmodule
