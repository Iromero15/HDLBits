module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); 

    // Definimos las señales que van al contador interno
    assign c_enable = enable;
    
    // El load se activa con el reset O cuando llegamos al límite (12)
    // Usamos 4'd12 para que sea bien legible
    assign c_load = reset | (enable && (Q == 4'd12));
    
    // Siempre que cargamos, cargamos un 1
    assign c_d = 4'd1;

    // Instanciamos el contador que nos dieron
    // Conectamos las señales de control que definimos arriba
    count4 the_counter (
        .clk(clk),
        .enable(c_enable),
        .load(c_load),
        .d(c_d),
        .Q(Q)
    );

endmodule