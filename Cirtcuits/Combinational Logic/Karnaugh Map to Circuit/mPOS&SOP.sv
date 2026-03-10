module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
); 

    // Mínimo SOP: Sumamos los grupos de 1s
    assign out_sop = (c & d) | (~a & ~b & c);

    // Mínimo POS: Multiplicamos los grupos de 0s
    assign out_pos = (c) & (~a | d) & (~b | d);

endmodule