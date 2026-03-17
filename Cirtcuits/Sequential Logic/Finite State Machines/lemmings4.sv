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

    parameter L=0, R=1, FL=2, FR=3, DL=4, DR=5, DEAD=6;
    
    reg [6:0] state;
    wire [6:0] next_state; // Tiene que ser wire para usar con 'assign'

    // --- CONTADOR SATURADO ---
    // Si llega a 31, se queda ahí. Así evitamos que vuelva a 0 en caídas eternas.
    reg [4:0] count;
    always @(posedge clk or posedge areset) begin
        if (areset) count <= 0;
        else if (state[FL] || state[FR]) begin
            if (count < 5'd31) count <= count + 1'b1; 
        end
        else count <= 0;
    end

    // Señal pura para no ensuciar las ecuaciones
    wire splat = (count >= 5'd20);

    // --- LÓGICA DE TRANSICIÓN (Cerebro) ---

    // 1. CAER
    assign next_state[FL] = !ground & (state[L] | state[FL] | state[DL]);
    assign next_state[FR] = !ground & (state[R] | state[FR] | state[DR]);

    // 2. CAVAR
    assign next_state[DL] = ground & (state[DL] | (state[L] & dig));
    assign next_state[DR] = ground & (state[DR] | (state[R] & dig));

    // 3. CAMINAR
    assign next_state[L] = ground & (
        (state[FL] & !splat) |            // Aterriza sano (count <= 19)
        (state[L] & !dig & !bump_left) |  // Sigue caminando
        (state[R] & !dig & bump_right)    // Rebotó
    );
    assign next_state[R] = ground & (
        (state[FR] & !splat) |
        (state[R] & !dig & !bump_right) | 
        (state[L] & !dig & bump_left)
    );

    // 4. SPLAT (Muerte: no sale más de acá)
    assign next_state[DEAD] = state[DEAD] | (ground & splat & (state[FL] | state[FR]));

    // --- MEMORIA ---
    always @(posedge clk or posedge areset) begin    
        if (areset) state <= 7'b0000001; 
        else        state <= next_state;
    end

    // --- SALIDAS ---
    // Si el bit de DEAD es 1, todas estas dan 0 (el Lemming "desaparece")
    assign walk_left  = state[L];
    assign walk_right = state[R];
    assign aaah       = state[FL] | state[FR];
    assign digging    = state[DL] | state[DR];

endmodule