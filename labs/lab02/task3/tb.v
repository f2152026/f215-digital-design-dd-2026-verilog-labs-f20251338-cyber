// tb.v
// Self-checking testbench for 2-bit comparator

module tb;

    // DUT inputs
    reg [1:0] t_A;
    reg [1:0] t_B;

    // DUT outputs
    wire t_GT;
    wire t_LT;
    wire t_EQ;


    // Instantiate DUT

    comp2 DUT
    (
        .A(t_A),
        .B(t_B),
        .GT(t_GT),
        .LT(t_LT),
        .EQ(t_EQ)
    );


    // Waveform dump

    string vcd_file;

    initial begin
        if ($value$plusargs("vcd=%s", vcd_file)) begin
            $dumpfile(vcd_file);
            $dumpvars(0, tb);
        end
    end



    // Self checking test

    integer a;
    integer b;

    reg expected_GT;
    reg expected_LT;
    reg expected_EQ;


    initial begin

        // Test all 16 combinations

        for(a = 0; a < 4; a = a + 1)
        begin

            for(b = 0; b < 4; b = b + 1)
            begin

                t_A = a;
                t_B = b;

                #5;


                // Calculate expected result

                expected_GT = (a > b);
                expected_LT = (a < b);
                expected_EQ = (a == b);


                // Compare DUT output

                if ((t_GT !== expected_GT) ||
                    (t_LT !== expected_LT) ||
                    (t_EQ !== expected_EQ))
                begin

                    $display("ERROR!");
                    $display("A=%d B=%d", a, b);

                    $display("Expected: GT=%b LT=%b EQ=%b",
                             expected_GT,
                             expected_LT,
                             expected_EQ);

                    $display("Actual:   GT=%b LT=%b EQ=%b",
                             t_GT,
                             t_LT,
                             t_EQ);

                end

                else
                begin

                    $display("PASS: A=%d B=%d | GT=%b LT=%b EQ=%b",
                             a,
                             b,
                             t_GT,
                             t_LT,
                             t_EQ);

                end


            end

        end


        $finish;

    end

endmodule