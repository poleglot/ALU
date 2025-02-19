module alu(
    input   logic   [31:0]  a_i,
    input   logic   [31:0]  b_i,
    input   logic   [4:0]   alu_op_i,
    
    output  logic   [31:0]  result_o,
    output  logic           flag_o 
);
    
    parameter ALU_ADD  = 5'b00000;
    parameter ALU_SUB  = 5'b01000;
    
    parameter ALU_XOR  = 5'b00100;
    parameter ALU_OR   = 5'b00110;
    parameter ALU_AND  = 5'b00111;
    
    // shifts
    parameter ALU_SRA  = 5'b01101;
    parameter ALU_SRL  = 5'b00101;
    parameter ALU_SLL  = 5'b00001;
    
    // comparisons
    parameter ALU_LTS  = 5'b11100;
    parameter ALU_LTU  = 5'b11110;
    parameter ALU_GES  = 5'b11101;
    parameter ALU_GEU  = 5'b11111;
    parameter ALU_EQ   = 5'b11000;
    parameter ALU_NE   = 5'b11001;
    
    // set lower than operations
    parameter ALU_SLTS = 5'b00010;
    parameter ALU_SLTU = 5'b00011;
    
    logic sum;
    
    fullAdder32 adder(
        .a_i(a_i),
        .b_i(b_i),
        .carry_i(1'b0),
        .carry_o(1'b0),
        .sum_o(sum)
    );
    
    always_comb begin
        case(alu_op_i) 
            ALU_LTS:    flag_o = $signed(a_i) < $signed(b_i);
            ALU_LTU:    flag_o = a_i < b_i;
            ALU_GES:    flag_o = $signed(a_i) >= $signed(b_i);
            ALU_GEU:    flag_o = a_i >= b_i;
            ALU_EQ:     flag_o = a_i == b_i;
            ALU_NE:     flag_o = a_i != b_i;
                
            default:    flag_o = 'b0;
        endcase
        case(alu_op_i)
            ALU_ADD:    result_o = sum;
            ALU_SUB:    result_o = a_i - b_i;
            ALU_SLL:    result_o = a_i << b_i[4:0];
            ALU_SLTS:   result_o = $signed(a_i) < $signed(b_i);
            ALU_SLTU:   result_o = a_i < b_i;
            ALU_XOR:    result_o = a_i ^ b_i;
            ALU_SRL:    result_o = a_i >> b_i[4:0];
            ALU_SRA:    result_o = $signed(a_i) >>> b_i[4:0];
            ALU_OR:     result_o = a_i || b_i;
            ALU_AND:    result_o = a_i && b_i;
                
            default:    result_o = 'b0;
        endcase
    end
endmodule