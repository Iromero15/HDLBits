module top_module (
    input clk,
    input x,
    output z
); 

    // Usamos wire para las conexiones internas
    wire q1, q2, q3;
    wire d1, d2, d3;

    // Lógica combinacional: usamos !q directamente para evitar el delay del registro
    assign d1 = x ^ q1;
    assign d2 = x & !q2;
    assign d3 = x | !q3;

    // Salida NOR
    assign z = !(q1 | q2 | q3);

    // Instancias de Flip-Flops (asumimos que arrancan en 0)
    dff_module inst1 (d1, clk, q1);
    dff_module inst2 (d2, clk, q2);
    dff_module inst3 (d3, clk, q3);

endmodule

module dff_module (
    input d,
    input clk,
    output reg q = 1'b0 // Inicialización para la simulación
);
    always @(posedge clk) begin
        q <= d; // SIEMPRE usamos <= en lógica secuencial
    end
endmodule