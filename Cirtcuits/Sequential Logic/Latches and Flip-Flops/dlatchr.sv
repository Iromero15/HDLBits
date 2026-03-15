module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output q);

    always @(posedge clk) begin
        if (r) begin
            // Si el reset está en alto durante el flanco, ponemos la salida en 0
            q <= 1'b0;
        end else begin
            // Si no hay reset, la salida copia a la entrada
            q <= d;
        end
    end

endmodule