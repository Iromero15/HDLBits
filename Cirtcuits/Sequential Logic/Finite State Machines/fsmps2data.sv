module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Reset sincrónico
    output [23:0] out_bytes,
    output done); 

    // Definimos los 4 estados de la recepción
    parameter BYTE1=0, BYTE2=1, BYTE3=2, DONE=3;
    reg [1:0] state, next_state;
    reg [23:0] data;
    // 1. Lógica de transición (El Cerebro)
    always @(*) begin
        case (state)
            // Buscamos el primer byte. Si in[3] es 1, pasamos al segundo.
            BYTE1: next_state = in[3] ? BYTE2 : BYTE1;
            
            // Los siguientes dos bytes entran sin importar su contenido
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            
            // ¡OJO ACÁ! Mientras estamos en DONE (mostrando el resultado), 
            // ya está entrando el byte del próximo paquete. 
            // Hay que evaluarlo al vuelo.
            DONE:  next_state = in[3] ? BYTE2 : BYTE1; 
            
            default: next_state = BYTE1;
        endcase
    end
    always @(posedge clk) begin
        case (state)
            BYTE1: data[23:16] = in;
            BYTE2: data[15:8]  = in;
            BYTE3: data[7:0]   = in;
            DONE:  data[23:16] = in;
        endcase
    end
    // 2. Memoria (Flip-Flops)
    always @(posedge clk) begin
        if (reset) 
            state <= BYTE1;
        else 
            state <= next_state;
    end

    // 3. Salida (Moore)
    // El 'done' solo se prende cuando llegamos al último estado.
    assign done = (state == DONE);
    assign out_bytes = data;

endmodule