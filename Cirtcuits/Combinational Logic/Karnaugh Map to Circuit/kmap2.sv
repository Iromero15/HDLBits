module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 

    // Simplificación por Mapas de Karnaugh
    assign out = (~b & ~c) | (~a & ~d) | (b & c & d) | (a & c & d);

endmodule