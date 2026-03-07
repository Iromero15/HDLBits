module top_module(
    input [31:0] a,
    input [31:0] b,
    input sub,
    output [31:0] sum
);

    wire [31:0] bsub;
    wire cout;
    wire cout2;

    assign bsub = b ^ {32{sub}};
    add16 instance1 (a[15:0], bsub[15:0], sub, sum[15:0], cout);
    add16 instance2 (a[31:16], bsub[31:16], cout, sum[31:16], cout2);

endmodule