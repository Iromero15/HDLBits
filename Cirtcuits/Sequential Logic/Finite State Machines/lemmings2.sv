module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 

    parameter LEFT=2'b00, RIGHT=2'b01, FALLLEFT = 2'b10, FALLRIGHT = 2'b11;
    reg [3:0] state, next_state;

    assign next_state[LEFT]  = ground & (state[LEFT]&(!bump_left) | state[RIGHT]&(bump_right)  | state[FALLLEFT]);
    assign next_state[RIGHT] = ground & (state[LEFT]&(bump_left)  | state[RIGHT]&(!bump_right) | state[FALLRIGHT]);
    assign next_state[FALLLEFT] = state[LEFT]&(~ground)  | state[FALLLEFT]&(~ground);
    assign next_state[FALLRIGHT] =state[RIGHT]&(~ground) | state[FALLRIGHT]&(~ground);

    always @(posedge clk or posedge areset) begin    
        if (areset) begin
                state[LEFT] <= 1'b1; // Reset asincrónico vuela al estado ON
                state[RIGHT] <= 1'b0;
                state[FALLLEFT] <= 1'b0;
                state[FALLRIGHT] <= 1'b0;
            end
        else 
            state <= next_state;
    end


    assign walk_left = (state[LEFT]);
    assign walk_right = (state[RIGHT]);
    assign aaah = (state[FALLLEFT]) | (state[FALLRIGHT]);
endmodule


// module top_module(
//     input clk,
//     input areset,
//     input bump_left,
//     input bump_right,
//     input ground,
//     output walk_left,
//     output walk_right,
//     output aaah 
// ); 

//     reg [1:0] state;
//     wire [1:0] next_state;

//     // --- LÓGICA DEL PRÓXIMO ESTADO (Cerebro) ---

//     // Bit 1: ¿Voy a estar cayendo? 
//     // Es simple: si NO hay piso, el próximo ciclo voy a estar cayendo (1).
//     // Si HAY piso, el próximo ciclo voy a estar caminando (0).
//     assign next_state[1] = !ground;

//     // Bit 0: ¿Hacia dónde voy a estar mirando?
//     // Esta es la parte divertida. La dirección solo cambia si hay piso y choco.
//     // Si NO hay piso (estoy cayendo), mantengo la dirección que ya tenía.
//     assign next_state[0] = ground ? 
//                            ( (state[0] & !bump_right) | (!state[0] & bump_left) ) : 
//                            ( state[0] );

//     // --- LÓGICA SECUENCIAL (Memoria) ---
//     always @(posedge clk or posedge areset) begin
//         if (areset) 
//             state <= 2'b00; // Arranca caminando a la izquierda
//         else 
//             state <= next_state;
//     end

//     // --- SALIDAS (Decodificación) ---
//     // Caminar izquierda: No cae (s1=0) y mira izquierda (s0=0)
//     assign walk_left  = (state == 2'b00); 
    
//     // Caminar derecha: No cae (s1=0) y mira derecha (s0=1)
//     assign walk_right = (state == 2'b01);
    
//     // Gritar: Está cayendo (s1=1) sin importar la dirección
//     assign aaah       = state[1];

// endmodule