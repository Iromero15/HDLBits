module top_module(
    input clk,
    input load,
    input [255:0] data,
    output [255:0] q 
);

    // Representación interna en 2D para facilitar la vida
    reg [15:0][15:0] grid;
    assign q = grid;

    // Variables para los loops (se desenrollan en hardware)
    integer r, c, i, j;
    reg [3:0] neighbors;

    always @(posedge clk) begin
        if (load) begin
            grid <= data;
        end else begin
            // Para cada celda de la grilla 16x16
            for (r = 0; r < 16; r = r + 1) begin
                for (c = 0; c < 16; c = c + 1) begin
                    
                    // 1. Contamos vecinos (lógica toroidal)
                    neighbors = 0;
                    for (i = -1; i <= 1; i = i + 1) begin
                        for (j = -1; j <= 1; j = j + 1) begin
                            if (!(i == 0 && j == 0)) begin
                                // El truco del toroide: (pos + offset + size) % size
                                neighbors = neighbors + grid[(r + i + 16) % 16][(c + j + 16) % 16];
                            end
                        end
                    end

                    // 2. Aplicamos las reglas de Conway
                    case (neighbors)
                        4'd2:    grid[r][c] <= grid[r][c]; // Se mantiene igual
                        4'd3:    grid[r][c] <= 1'b1;       // Nace o sobrevive
                        default: grid[r][c] <= 1'b0;       // Muere (soledad o sobrepoblación)
                    endcase
                end
            end
        end
    end

endmodule