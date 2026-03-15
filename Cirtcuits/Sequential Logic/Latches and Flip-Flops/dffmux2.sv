module top_module (
    input clk,
    input w, R, E, L,
    output Q
);

    wire d, r_in;
    assign r_in = E ? w : Q;
    assign d = L ? R : r_in;

    always @(posedge clk) begin
        Q = d;
    end 

endmodule
