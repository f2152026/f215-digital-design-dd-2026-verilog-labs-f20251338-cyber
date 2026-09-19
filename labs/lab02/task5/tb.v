// tb.v
// Self-checking testbench for 4-bit ALU

module tb;


    // DUT inputs
    reg [3:0] t_a;
    reg [3:0] t_b;
    reg       t_op;


    // DUT output
    wire [3:0] t_result;



    // Instantiate DUT

    alu DUT
    (
        .a(t_a),
        .b(t_b),
        .op(t_op),
        .result(t_result)
    );



    // Waveform dump

    string vcd_file;

    initial begin

        if ($value$plusargs("vcd=%s", vcd_file)) begin

            $dumpfile(vcd_file);
            $dumpvars(0, tb);

        end

    end



    // Test variables

    integer a;
    integer b;

    reg [3:0] expected;



    // Self checking test

    initial begin


        // Test all combinations

        for(a = 0; a < 16; a = a + 1)
        begin

            for(b = 0; b < 16; b = b + 1)
            begin


                //-------------------------
                // Test Addition
                //-------------------------

                t_a  = a;
                t_b  = b;
                t_op = 1'b0;

                #5;


                expected = a + b;


                if(t_result !== expected)
                begin

                    $display("ADD ERROR");
                    $display("a=%d b=%d", a, b);
                    $display("Expected=%d Actual=%d",
                              expected,
                              t_result);
                end



                //-------------------------
                // Test Subtraction
                //-------------------------

                t_a  = a;
                t_b  = b;
                t_op = 1'b1;

                #5;


                expected = a - b;


                if(t_result !== expected)
                begin

                    $display("SUB ERROR");
                    $display("a=%d b=%d", a, b);
                    $display("Expected=%d Actual=%d",
                              expected,
                              t_result);

                end



            end

        end



        $display("ALU TEST COMPLETED");

        $finish;


    end



    // Monitor

    initial begin

        $monitor($time,
        " a=%d b=%d op=%b | result=%d",
        t_a,
        t_b,
        t_op,
        t_result);

    end


endmodule