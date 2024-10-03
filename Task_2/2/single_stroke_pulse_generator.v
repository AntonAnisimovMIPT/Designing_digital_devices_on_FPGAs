module single_stroke_pulse_generator (
    input wire clk,      
    input wire reset,    
    output reg pulse     
);

    reg [2:0] number_cycles;   

    always @(posedge clk) 
        begin
            if (reset) 
                begin
                    number_cycles <= 3'd0; 
                    pulse <= 1'b0;     
                end 
            else 
                begin
                    if (number_cycles == 3'd4) 
                        begin
                            number_cycles <= 3'd0; 
                            pulse <= 1'b1;     
                        end 
                    else 
                        begin
                            number_cycles <= number_cycles + 3'd1; 
                            pulse <= 1'b0;             
                        end
                end
        end

endmodule
