`timescale 1ns/1ps

module tb_fullAdder32();
    logic   [31:0]  a;
    logic   [31:0]  b;
    logic           cin;
    
    logic   [31:0]  sum;
    logic           cout;
    
    int err = 0;
    
    parameter CLK_PERIOD = 10;
    
    logic   clk = 0;
    always #(CLK_PERIOD / 2) clk = ~clk;
    
    fullAdder32 DUT(
        .a_i(a),
        .b_i(b),
        .carry_i(cin),
        .carry_o(cout),
        .sum_o(sum)
    );
    
    // Генерация входных воздействий
    initial begin
        $display("\n----------------------------------\nTest has been started\n----------------------------------\n");
        sequential_test();
        random_test();
        $display("\n----------------------------------\nTest has been finished\nError = %0d\n----------------------------------\n", err);
        $finish();
    end
    
    task sequential_test();
        @(posedge clk);
        a = 0;
        b = 0;
        cin = 0;
        @(posedge clk);
        for (int i = 0; i < 16; i++) begin
            a += 128;
            for (int j = 0; j < 16; j++) begin
                b += 128;
                cin = ~cin;
                @(posedge clk);
            end
        end
    endtask
    
    task random_test();
        repeat(1e3) begin
            a = $urandom();
            b = $urandom();
            cin = $urandom_range(0, 1);
            @(posedge clk);
        end
    endtask
    
    // Эталонное значение
    logic [32:0] golden;
    
    // Полученное значение
    logic [32:0] cur_v;
    
    // Проверка выходных значений
    initial begin
        forever begin
            @(negedge clk);
            cur_v = {cout, sum};
            golden = {1'b0, a} + {1'b0, b} + cin;
            if (golden != cur_v) begin
                err += 1;
                $error("Golden value: %0d\tCurrent value: %0d", golden, cur_v);
            end 
        end
    end
endmodule