module mux21 (
    input wire [7:0] data0,
    input wire [7:0] data1,
    input wire sel,
    output wire [7:0] out
);
    assign out = sel ? data1 : data0;
endmodule