module tb_fullAdder();

logic a;
logic b; 
logic cin;
logic cout;
logic sum;
logic [2:0] testCase;

fullAdder DUT(
    .a_i(a),
    .b_i(b),
    .sum_o(sum),
    .carry_i(cin),
    .carry_o(cout)
);

assign {a, b, cin} = testCase;

initial begin

$display("Test has been started\n");

testCase = 3'd0;
    repeat(8)begin
        #5ns
        testCase++;
        if (sum == (a + b + cin))
            $display("Good! %d + %d + %d = %d", cin, a, b, sum);
        else
            $display("Bad( %d + %d + %d = %d", cin, a, b, sum);
    end
    #5
    $stop;

end

endmodule