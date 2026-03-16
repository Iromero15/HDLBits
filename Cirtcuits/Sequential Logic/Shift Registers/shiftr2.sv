module top_module (
    input [3:0] SW,   // Entradas R3, R2, R1, R0
    input [3:0] KEY,  // clk=K[0], E=K[1], L=K[2], w=K[3]
    output [3:0] LEDR // Salidas Q3, Q2, Q1, Q0
);

    // Mapeo de señales para que sea más legible (Estilo técnico)
    wire clk = KEY[0];
    wire E   = KEY[1];
    wire L   = KEY[2];
    wire w   = KEY[3];

    // Instanciamos los 4 bloques encadenados
    // Stage 3 (el de más a la izquierda, recibe la entrada 'w' externa)
    MUXDFF inst3 (.clk(clk), .E(E), .L(L), .w_in(w),       .r_in(SW[3]), .Q(LEDR[3]));
    
    // Stage 2 recibe la salida del Stage 3
    MUXDFF inst2 (.clk(clk), .E(E), .L(L), .w_in(LEDR[3]), .r_in(SW[2]), .Q(LEDR[2]));
    
    // Stage 1 recibe la salida del Stage 2
    MUXDFF inst1 (.clk(clk), .E(E), .L(L), .w_in(LEDR[2]), .r_in(SW[1]), .Q(LEDR[1]));
    
    // Stage 0 recibe la salida del Stage 1
    MUXDFF inst0 (.clk(clk), .E(E), .L(L), .w_in(LEDR[1]), .r_in(SW[0]), .Q(LEDR[0]));

endmodule

// Módulo que contiene los 2 MUX y el DFF
module MUXDFF (
    input clk,
    input E,    // Selector de Enable/Shift
    input L,    // Selector de Load
    input w_in, // Entrada de desplazamiento (del vecino o externa)
    input r_in, // Entrada de carga paralela (Switch)
    output reg Q
);

    wire d_mux_e;
    wire d_final;

    // Lógica del primer MUX (E): 0 = Q (Hold), 1 = w_in (Shift)
    assign d_mux_e = E ? w_in : Q;

    // Lógica del segundo MUX (L): 0 = d_mux_e, 1 = r_in (Load)
    assign d_final = L ? r_in : d_mux_e;

    always @(posedge clk) begin
        // Usamos asignación no bloqueante (<=) para lógica secuencial
        Q <= d_final;
    end 

endmodule