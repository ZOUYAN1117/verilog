module mux2_1(
    input [3:0] a,
    input [3:0] b,
    input sel,
    output reg [3:0] data_out
);
    always @ (*) begin
      case (sel)
        1'b0: data_out = a;
        1'b1: data_out = b;
        default: data_out = a;
      endcase
    end
endmodule