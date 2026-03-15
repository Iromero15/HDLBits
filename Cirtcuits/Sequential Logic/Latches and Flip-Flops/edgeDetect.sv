module top_module (
    input clk,
    input [7:0] in,
    output reg [7:0] pedge
);

    // Registro para guardar el estado anterior de la entrada
    reg [7:0] in_prev;

    always @(posedge clk) begin
        // 1. Guardamos el valor actual para compararlo en el próximo ciclo
        in_prev <= in;

        // 2. La salida es 1 solo si 'in' es 1 Y 'in_prev' era 0
        // Esto se aplica bit a bit para los 8 bits del vector
        pedge <= in & ~in_prev;
    end

endmodule