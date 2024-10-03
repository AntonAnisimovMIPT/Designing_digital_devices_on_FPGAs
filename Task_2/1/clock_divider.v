module clock_divider (
    input wire clk,      
    input wire reset,    
    output reg clk_div6   
);

    reg [1:0] number_positive_fronts;  

    always @(posedge clk) 
    begin
        if (reset) 
            begin
                number_positive_fronts <= 2'd0; 
                clk_div6 <= 1'b0; 
            end 
        else 
            begin
            if (number_positive_fronts == 2'd2) 
                begin
                    number_positive_fronts <= 2'd0;   
                    clk_div6 <= ~clk_div6; 
                end 
            else 
                begin
                    number_positive_fronts <= number_positive_fronts + 2'd1; 
                end
            end
    end

endmodule
