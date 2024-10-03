`timescale 1ns / 1ns

module test_clock_divider;

    reg clk;
    reg reset;
    wire clk_div6;

    clock_divider uut (
        .clk(clk),
        .reset(reset),
        .clk_div6(clk_div6)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 0;
        #10;
        reset = 1; 
        #10;
        reset = 0;

    end

endmodule
