module fullAdder4(
    input   logic[3:0] a_i,
    input   logic[3:0] b_i,
    input   logic      carry_i,
    output  logic[3:0] sum_o,
    output  logic      carry_o
);

logic [3:0] c;
logic [3:0] q;

assign c[0] = carry_i;
assign carry_o = q[3];

assign c[3:1] = q[2:0];

fullAdder fullAdder[3:0](
    .a_i(a_i),
    .b_i(b_i),
    .carry_i(c),
    .sum_o(sum_o),
    .carry_o(q)
);

endmodule
