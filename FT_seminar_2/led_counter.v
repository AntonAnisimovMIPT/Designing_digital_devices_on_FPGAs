module led_counter (
    input wire clk,        
    input wire reset,      
    input wire button_inc,    
    input wire button_dec,  
    output reg [7:0] led  
);

    reg [2:0] counter;     
    reg button_r_inc, button_rr_inc; 
    reg button_r_dec, button_rr_dec; 
    wire push;              

/*
    always @(posedge clk) begin
        if (!reset) begin
            counter <= 3'b000;          
            led <= 8'b00000000;         
        end else begin
            if (push_inc) begin
                if (counter == 3'b111) begin
                    counter <= 3'b000; 
                end else begin
                    counter <= counter + 1;
                end
            end else if (push_dec) begin
                if (counter == 3'b000) begin
                    counter <= 3'b111;  
                end else begin
                    counter <= counter - 1;
                end
            end

            led <= (1 << (counter )) ;
        end
    end
    always @(posedge clk) begin
        button_r_inc <= button_inc;     
        button_rr_inc <= button_r_inc;  
    end
*/
    always @(posedge clk) begin
        button_r_dec <= button_dec;     
        button_rr_dec <= button_r_dec;  
    end

    assign push_inc = !button_r_inc && button_rr_inc;
    assign push_dec = !button_r_dec && button_rr_dec;

endmodule
