module top_module (
    input clk,
    input j,
    input k,
    output Q); 

    wire d;
    assign d = (j & ~Q) | (~k & Q);
    DFlipFlop inst (clk, d, Q);

endmodule

module DFlipFlop (
    input clk,
    input d,
    output q = 1'b0
);
    always @(posedge clk) begin
        q <= d;
    end
    
endmodule