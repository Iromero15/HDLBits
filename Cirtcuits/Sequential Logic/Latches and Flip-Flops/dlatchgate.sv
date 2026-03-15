module top_module (
    input clk,
    input in, 
    output out);

    wire d;

    assign d = out ^ in;

    latchD inst (clk, d, out);

endmodule

module latchD (
    input clk,
    input d,
    output q
);

    always @(posedge clk) begin
        q = d;
    end

endmodule