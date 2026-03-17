module top_module(
    input clk,
    input areset,    // Reset asincrónico al estado B
    input in,
    output out
);  

    // Definimos los estados. Usamos 1 bit porque son solo dos.
    parameter A=0, B=1; 
    reg state, next_state;

    // 1. Lógica combinacional: ¿A dónde vamos?
    always @(*) begin    
        case (state)
            B: next_state = in ? B : A; // Si estoy en B y viene 0, voy a A
            A: next_state = in ? A : B; // Si estoy en A y viene 0, voy a B
            default: next_state = B;
        endcase
    end

    // 2. Lógica secuencial: El "latido" del reloj
    always @(posedge clk or posedge areset) begin    
        if (areset) 
            state <= B; // Reset asincrónico vuela al estado B
        else 
            state <= next_state;
    end

    // 3. Lógica de salida: Moore (solo depende del estado actual)
    assign out = (state == B);

endmodule