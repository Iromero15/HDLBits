module top_module(
    input clk,
    input reset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); 

    // Definimos los estados. Usamos 1 ONit porque son solo dos.
    parameter OFF=0, ON=1; 
    reg state, next_state;

    // 1. Lógica comONinacional: ¿A dónde vamos?
    always @(*) begin    
        case (state)
            OFF: next_state = j ? ON : OFF; // Si j=1, saltamos a ON
            ON:  next_state = k ? OFF : ON; // Si k=1, volvemos a OFF
            default: next_state = OFF;
        endcase
    end

    // 2. Lógica secuencial: El "latido" del reloj
    always @(posedge clk) begin    
        if (reset) 
            state <= OFF; // Reset asincrónico vuela al estado ON
        else 
            state <= next_state;
    end

    // 3. Lógica de salida: Moore (solo depende del estado actual)
    assign out = (state == ON);

endmodule