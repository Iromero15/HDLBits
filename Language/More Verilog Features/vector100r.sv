module top_module( 
    input [99:0] in,
    output [99:0] out
);

    // Necesitamos una variable para el índice del bucle
    integer i;

    always @(*) begin
        // El bucle recorre los 100 bits y hace la conexión "espejo"
        for (i = 0; i < 100; i = i + 1) begin
            out[i] = in[99-i];
        end
    end

endmodule
