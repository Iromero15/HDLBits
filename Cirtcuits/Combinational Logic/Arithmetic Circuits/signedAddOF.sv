module top_module (
    input [7:0] a,
    input [7:0] b,
    output [7:0] s,
    output overflow
); 

    // La suma es la de siempre
    assign s = a + b;

    // Lógica de overflow: 
    // Si los signos de A y B son iguales, pero el de S es distinto, hubo bardo.
    assign overflow = (a[7] == b[7]) && (s[7] != a[7]);

endmodule