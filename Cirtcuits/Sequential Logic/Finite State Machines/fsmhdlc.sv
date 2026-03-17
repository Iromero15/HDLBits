module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);

    // Definimos los estados contando la cantidad de '1's consecutivos
    parameter NONE=0, ONE=1, TWO=2, THREE=3, FOUR=4, FIVE=5, SIX=6;
    // Estados de salida
    parameter DISC=7, FLAG=8, ERR=9;

    reg [3:0] state, next_state;

    // 1. Lógica de transición
    always @(*) begin
        case(state)
            NONE:  next_state = in ? ONE : NONE;
            ONE:   next_state = in ? TWO : NONE;
            TWO:   next_state = in ? THREE : NONE;
            THREE: next_state = in ? FOUR : NONE;
            FOUR:  next_state = in ? FIVE : NONE;
            
            // Llegamos a 5 unos. Si viene un 0, descartamos. Si viene un 1, seguimos.
            FIVE:  next_state = in ? SIX : DISC;
            
            // Llegamos a 6 unos. Si viene un 0, es un Flag. Si viene un 1, es Error.
            SIX:   next_state = in ? ERR : FLAG;
            
            // Desde los estados de salida, evaluamos el bit que acaba de entrar
            DISC:  next_state = in ? ONE : NONE;
            FLAG:  next_state = in ? ONE : NONE;
            
            // Si estamos en error, nos quedamos ahí hasta que llegue un 0 (idle)
            ERR:   next_state = in ? ERR : NONE;
            
            default: next_state = NONE;
        endcase
    end

    // 2. Memoria Secuencial
    always @(posedge clk) begin
        if (reset)
            state <= NONE; // Comportamiento como si el anterior fuera 0
        else
            state <= next_state;
    end

    // 3. Salidas Moore
    assign disc = (state == DISC);
    assign flag = (state == FLAG);
    assign err  = (state == ERR);

endmodule