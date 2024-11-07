module blinking_led (
    input wire clk,             
    input wire reset,           
    input wire [13:0] switches, 
    input wire update_button,   
    output reg LEDG8            
);

    reg [13:0] blink_period;    
    reg update_r, update_rr;    
    wire update_pulse;          

    reg [31:0] counter;         
    reg led_state;              

    parameter FREQ = 50000000;
    parameter TACTS_PER_MILISECOND = FREQ / 1000;

    always @(posedge clk) begin
        if (!reset) begin
            blink_period <= 14'd500;  // период по умолчанию (500 мс)
        end else if (update_pulse) begin
            blink_period <= switches; 
        end
    end

    always @(posedge clk) begin
        update_r <= update_button;
        update_rr <= update_r;
    end

    assign update_pulse = update_rr && !update_r;

    always @(posedge clk) begin
        if (!reset) begin
            counter <= 0;
            led_state <= 0;
            LEDG8 <= 0;
        end else if (counter >= blink_period * TACTS_PER_MILISECOND / 2) begin
            counter <= 0;             
            led_state <= ~led_state;  
            LEDG8 <= led_state;
        end else begin
            counter <= counter + 1;   
        end
    end

endmodule
