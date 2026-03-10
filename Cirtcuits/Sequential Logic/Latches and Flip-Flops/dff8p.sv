module top_module (
    input clk,
    input reset,            // Reset sincrónico
    input [7:0] d,
    output reg [7:0] q      // Agregamos 'reg' porque se asigna en un always
);

    // El bloque solo es sensible al flanco ascendente del reloj
    always @(negedge clk) begin
        if (reset) begin
            // Si el reset está en alto durante el flanco, ponemos la salida en 0
            q <= 8'h34;
        end else begin
            // Si no hay reset, la salida copia a la entrada
            q <= d;
        end
    end

endmodule