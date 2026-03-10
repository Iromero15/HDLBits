module top_module (
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output [15:0] q
);

    always @(posedge clk) begin
        if (!resetn) begin
            // Reset sincrónico, activo en bajo (resetn == 0)
            // Reseteamos todo el registro a cero de una
            q <= 16'h0000;
        end
        else begin
            // El byte-enable controla la escritura del dato 'd'
            if (byteena[0]) q[7:0]  <= d[7:0];
            if (byteena[1]) q[15:8] <= d[15:8];
        end
    end

endmodule