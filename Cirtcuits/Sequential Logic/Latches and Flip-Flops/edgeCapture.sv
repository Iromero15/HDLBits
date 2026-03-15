module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out
);

    reg [31:0] in_prev;

    always @(posedge clk) begin
        // 1. Guardamos el estado anterior para detectar el flanco
        in_prev <= in;

        // 2. Lógica de captura con prioridad de reset
        if (reset) begin
            // Si reset es 1, limpiamos todos los eventos capturados
            out <= 32'b0;
        end else begin
            // Mantenemos los 1s que ya estaban (out) 
            // y agregamos los nuevos flancos descendentes (in_prev & ~in)
            out <= out | (in_prev & ~in);
        end
    end

endmodule