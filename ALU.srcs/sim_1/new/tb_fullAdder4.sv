module tb_fullAdder4();

logic   [3:0]   a;
logic   [3:0]   b;
logic           cin;

logic   [8:0]   testCase;

logic   [3:0]   sum;
logic           cout;

fullAdder4 DUT(
    .a_i(a),
    .b_i(b),
    .carry_i(cin),
    .sum_o(sum),
    .carry_o(cout)
);

assign {a, b, cin} = testCase;

initial begin 
    $display("Test has been started\n");
    testCase = 9'd0;
    repeat(512) begin
        #5ns
        testCase++;
        if (sum == (a + b + cin))
            $display("Good!  Sum: %d + %d + %d = %d   Cout: %d", a, b, cin, sum, cout);
        else
            $display("Bad(  %d + %d + %d = %d   Cout: %d", a, b, cin, sum, cout); 
    end
    #2ns
    $stop;
end
endmodule