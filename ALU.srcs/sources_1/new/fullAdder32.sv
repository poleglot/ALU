module fullAdder32(
    input   logic   [31:0]  a_i,
    input   logic   [31:0]  b_i,
    input   logic           carry_i,
    
    output  logic   [31:0]  sum_o,
    output  logic           carry_o 
);

    logic [7:0] c;
    logic [7:0] q;
    
    assign c[0] = carry_i;
    assign carry_o = q[7];
    
    assign c[7:1] = q[6:0];
    
    fullAdder4 fullAdder[7:0](
        .a_i(a_i),
        .b_i(b_i),
        .carry_i(c),
        .sum_o(sum_o),
        .carry_o(q)
    );

endmodule