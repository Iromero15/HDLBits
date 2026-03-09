module top_module( 
    input a, b, sel,
    output out ); 

    always @(*) begin
        if(sel) out = b;
        else out = a;
    end

endmodule
