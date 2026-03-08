module top_module(
    input a, 
    input b,
    output wire out_assign,
    output reg out_alwaysblock
);

    assign out_assign = a & b;
    always@(*) out_alwaysblock = a & b;

endmodule

// A note on wire vs. reg: The left-hand-side of an assign statement must be a net type (e.g., wire), while the left-hand-side of a procedural assignment
// (in an always block) must be a variable type (e.g., reg). These types (wire vs. reg) have nothing to do with what hardware is synthesized, and is just 
// syntax left over from Verilog's use as a hardware simulation language. 