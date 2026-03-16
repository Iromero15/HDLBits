module top_module (
    input clk,
    input reset,      // Synchronous active-high reset
    output [3:0] q);

    always @(posedge clk) begin
        if (reset) 
        q = 4'b0;
        else
        q = q + 1;

    end

endmodule

// MODO FIERRO
// module top_module (
//     input clk,
//     input reset,
//     output reg [3:0] q
// );

//     // Cables para la lógica de excitación (las entradas D de los flip-flops)
//     wire [3:0] d;

//     // Lógica de "Toggle" con compuertas XOR y AND
//     // El bit i cambia si todos los anteriores son 1
//     assign d[0] = q[0] ^ 1'b1;
//     assign d[1] = q[1] ^ (q[0]);
//     assign d[2] = q[2] ^ (q[1] & q[0]);
//     assign d[3] = q[3] ^ (q[2] & q[1] & q[0]);

//     // Banco de Flip-Flops con Reset Sincrónico
//     always @(posedge clk) begin
//         if (reset) begin
//             q <= 4'b0;
//         end else begin
//             // Conectamos la salida de nuestras "compuertas" a los FFs
//             q <= d;
//         end
//     end

// endmodule