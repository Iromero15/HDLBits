module top_module(
    input clk,
    input areset,    
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    // 6 estados = 6 bits para One-Hot
    parameter L=0, R=1, FL=2, FR=3, DL=4, DR=5;
    reg [5:0] state, next_state;

    // --- LÓGICA DE TRANSICIÓN (Cerebro) ---

    // 1. CAER (Prioridad Máxima: !ground)
    assign next_state[FL] = !ground & (state[L] | state[FL] | state[DL]);
    assign next_state[FR] = !ground & (state[R] | state[FR] | state[DR]);

    // 2. CAVAR (Solo si venías caminando y tenés piso. NO si venís de caer)
    assign next_state[DL] = ground & (state[DL] | (state[L] & dig));
    assign next_state[DR] = ground & (state[DR] | (state[R] & dig));

    // 3. CAMINAR (Si hay piso, no estás cavando y venís de caminar o de caer)
    assign next_state[L] = ground & (
        state[FL] |                       // Rescata de la caída (ignora dig)
        (state[L] & !dig & !bump_left) |  // Sigue caminando
        (state[R] & !dig & bump_right)    // Rebotó
    );

    assign next_state[R] = ground & (
        state[FR] | 
        (state[R] & !dig & !bump_right) | 
        (state[L] & !dig & bump_left)
    );

    // --- MEMORIA ---
    always @(posedge clk or posedge areset) begin    
        if (areset) state <= 6'b000001; // Arranca en LEFT (bit 0)
        else        state <= next_state;
    end

    // --- SALIDAS ---
    assign walk_left  = state[L];
    assign walk_right = state[R];
    assign aaah       = state[FL] | state[FR];
    assign digging    = state[DL] | state[DR];

endmodule