module top_module (input a, input b, input c, output out);//
	wire help;
    andgate inst1 ( help, a, b, c,1'b1, 1'b1);
	assign out = !help;
endmodule
