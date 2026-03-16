module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);


    assign ena[1] = (q [3:0] == 4'd9);
    assign ena[2] = (q [3:0] == 4'd9 && q [7:4] == 4'd9);
    assign ena[3] = (q [3:0] == 4'd9 && q [7:4] == 4'd9 && q [11:8] == 4'd9);

    bcdcount inst1 (clk, 1'b1  , reset, q [3:0]);
    bcdcount inst2 (clk, ena[1], reset, q [7:4]);
    bcdcount inst3 (clk, ena[2], reset, q [11:8]);
    bcdcount inst4 (clk, ena[3], reset, q [15:12]);

endmodule
module bcdcount (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);

    always @(posedge clk) begin
        if (reset) q = 4'b0;
        else if (slowena) begin
            if (q == 9) q = 0;
            else q = q + 1; 
        end
    end

endmodule
