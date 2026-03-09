module top_module ( 
    input p1a, p1b, p1c, p1d,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );


    fourAnd inst1 (p1a, p1b, p1c, p1d, p1y);
    fourAnd inst2 (p2a, p2b, p2c, p2d, p2y);

endmodule


module fourAnd (
    input pa, pb, pc, pd,
    output py
);

    assign py = !(pa & pb & pc & pd);

endmodule