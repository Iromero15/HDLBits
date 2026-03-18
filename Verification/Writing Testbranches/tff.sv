module top_module ();
    reg clk, reset, t;
    wire q;


    tff inst1 (clk, reset, t, q);


    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 0;
        t = 0;
        #5;
        reset = 1;
        #5;
        reset = 0;
        #5;
        t = 1;
        #5;
        t = 0;
    end


endmodule
