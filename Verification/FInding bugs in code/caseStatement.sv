module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid 
);

    always @(*) begin // ¡Fundamental el begin aquí!
        case (code)
            8'h45: out = 4'd0;
            8'h16: out = 4'd1;
            8'h1e: out = 4'd2;
            8'h26: out = 4'd3; // Cambiado de 'd a 'h
            8'h25: out = 4'd4;
            8'h2e: out = 4'd5;
            8'h36: out = 4'd6;
            8'h3d: out = 4'd7;
            8'h3e: out = 4'd8;
            8'h46: out = 4'd9; // Corregido el ancho a 8 bits
            default: out = 4'd0; // ¡La Ref pide 0 para scancodes inválidos!
        endcase

        // Lógica de validación limpia
        if (out <= 4'd9 && code != 8'h00) begin 
            // Esto es más robusto, pero el default anterior ya te salva
            valid = 1'b1;
        end else if (code == 8'h45 || code == 8'h16 || code == 8'h1e || 
                     code == 8'h26 || code == 8'h25 || code == 8'h2e || 
                     code == 8'h36 || code == 8'h3d || code == 8'h3e || 
                     code == 8'h46) begin
            valid = 1'b1;
        end else begin
            valid = 1'b0;
        end
        
        // Versión simplificada para HDLBits:
        valid = (out != 4'd0) || (code == 8'h45); 
        // Nota: El scancode 45 mapea a 0, por eso el or especial.
    end

endmodule