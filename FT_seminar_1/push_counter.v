module push_counter (
    input wire clk,         
    input wire reset,       
    input wire button_inc,  
    input wire button_dec,       
    output wire [6:0] hex_num  
);

    reg [3:0] counter;          
    reg button_r_inc, button_rr_inc;  
    reg button_r_dec, button_rr_dec;  
    wire push_inc;                   
    wire push_dec;                            

    seven_segment_display display(
        .hex(counter),
        .s_seg(hex_num)
    );      

    always @(posedge clk) begin
        if (!reset) begin
            counter <= 4'b0000;  
        end else begin
            if (push_inc) begin
                counter <= counter + 1; 
            end else if (push_dec) begin
                counter <= counter - 1;  
            end
        end
    end

    always @(posedge clk) begin
        button_r_inc <= button_inc;    
        button_rr_inc <= button_r_inc;  
    end

    always @(posedge clk) begin
        button_r_dec <= button_dec;    
        button_rr_dec <= button_r_dec;  
    end
    
    assign push_inc = !button_r_inc && button_rr_inc;  

    assign push_dec = !button_r_dec && button_rr_dec;   

endmodule
