module stopwatch (
    input wire clk,            
    input wire reset,           
    input wire start_stop,     
    output wire [6:0] hex1,     
    output wire [6:0] hex2,     
    output wire [6:0] hex3      
);

    parameter CLK_FREQ_HZ = 50000000;
    parameter TENTH_SEC_TICKS = CLK_FREQ_HZ / 10;

    reg [22:0] tick_counter = 0; // для 0.1 секунды
    reg [3:0] sec_tenths = 0;    
    reg [3:0] sec_units = 0;     
    reg [3:0] sec_tens = 0;      
    reg running = 0;            
    reg start_stop_prev = 0;     

    always @(posedge clk) begin
        if (!reset) begin
            running <= 0; 
        end else if (start_stop && !start_stop_prev) begin
            running <= ~running; 
        end
        start_stop_prev <= start_stop; 
    end

    always @(posedge clk) begin
        if (!reset) begin
            tick_counter <= 0;
            sec_tenths <= 0;
            sec_units <= 0;
            sec_tens <= 0;
        end else if (running) begin
            if (tick_counter == TENTH_SEC_TICKS - 1) begin
                tick_counter <= 0;

                if (sec_tenths == 9) begin
                    sec_tenths <= 0;
                    if (sec_units == 9) begin
                        sec_units <= 0;
                        if (sec_tens == 9) begin
                            sec_tens <= 0;
                        end else begin
                            sec_tens <= sec_tens + 1;
                        end
                    end else begin
                        sec_units <= sec_units + 1;
                    end
                end else begin
                    sec_tenths <= sec_tenths + 1;
                end
            end else begin
                tick_counter <= tick_counter + 1;
            end
        end
    end

    seven_segment_display disp_sec_tenths (.hex(sec_tenths), .s_seg(hex1));
    seven_segment_display disp_sec_units (.hex(sec_units), .s_seg(hex2));
    seven_segment_display disp_sec_tens (.hex(sec_tens), .s_seg(hex3));

endmodule
