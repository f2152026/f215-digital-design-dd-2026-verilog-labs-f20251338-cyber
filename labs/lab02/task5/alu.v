// alu.v
// 1-bit-opcode ALU: op=0 -> add, op=1 -> sub.
// 4-bit operands.
// Subtraction uses two's complement:
// a - b = a + (~b + 1)

module alu (
    input      [3:0] a,
    input      [3:0] b,
    input             op,      // 0 = add, 1 = sub
    output reg [3:0] result
);

    reg [3:0] b_inv;
    reg [3:0] b_twos;


    // Combinational ALU logic
    // @(*) automatically includes a, b and op in sensitivity list

    always @(*)
    begin

        case(op)

            // Addition
            1'b0:
            begin
                result = a + b;
            end


            // Subtraction using two's complement
            1'b1:
            begin
                b_inv  = ~b;
                b_twos = b_inv + 1'b1;

                result = a + b_twos;
            end


            // Default safety case
            default:
            begin
                result = 4'b0000;
            end

        endcase

    end


endmodule