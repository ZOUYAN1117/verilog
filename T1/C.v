module alu #(
    parameter WIDTH = 4  // 数据位宽，默认 4 位
) (
    input      [WIDTH-1:0] in1,
    input      [WIDTH-1:0] in2,
    input      [      2:0] op,
    output reg [WIDTH-1:0] out,
    output reg             carry
);
  always @(*) begin
    out   = 0;
    carry = 0;
    case (op)
      3'b000: begin
        out = in1 + in2;
        if (out < in1 | out < in2) carry = 1;
        else carry = 0;
      end
      3'b001: begin
        out = in1 - in2;
        if (in1 < in2) carry = 1;
        else carry = 0;
      end
      3'b010:  out = in1 & in2;
      3'b011:  out = in1 | in2;
      3'b100:  out = in1 ^ in2;
      3'b101: begin
        if (in1 == in2) carry = 1;
        else carry = 0;
      end
      default: carry = 0;
    endcase
  end
endmodule
