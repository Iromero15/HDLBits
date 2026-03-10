module top_module (
    input clk,
    input areset,   // Reset asincrónico (activo en alto)
    input [7:0] d,
    output reg [7:0] q // Usamos reg porque asignamos dentro de un always
);

    // Agregamos 'posedge areset' a la lista para que sea asincrónico
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Si el reset se activa, la salida se limpia inmediatamente
            q <= 8'b0;
        end else begin
            // Si no hay reset, en cada flanco de reloj se guarda el dato
            q <= d;
        end
    end

endmodule