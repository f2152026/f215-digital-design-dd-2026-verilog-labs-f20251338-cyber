// and_beh_intra.v
// AND gate with intra-assignment delay

module and_beh_intra (
    input  a,
    input  b,
    output reg y
);


always @(*)
begin

    y = #5 (a & b);

end


endmodule