module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);

    wire [7:0] w1;
    wire [7:0] w2;
    wire [7:0] w3;

    my_dff8 instance1 (clk, d, w1);
    my_dff8 instance2 (clk, w1, w2);
    my_dff8 instance3 (clk, w2, w3);

    always @(*) begin
        case(sel)
            2'b00: q = d;   // Sin delay (entrada directa)
            2'b01: q = w1;  // 1 ciclo de delay
            2'b10: q = w2;  // 2 ciclos de delay
            2'b11: q = w3;  // 3 ciclos de delay
            default: q = 8'b0; // Por seguridad, aunque sel solo tiene 2 bits
        endcase
    end

endmodule