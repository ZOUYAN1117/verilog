module bin2gray #(
    parameter WIDTH = 5
) (
    input [WIDTH-1:0] bin_value,
    output reg [WIDTH-1:0] gray_value
);
  integer i;
  always @(*) begin
    gray_value[WIDTH-1] = bin_value[WIDTH-1];
    for (i = 0; i < WIDTH - 1; i = i + 1) begin
      gray_value[i] = bin_value[i+1] ^ bin_value[i];
    end
  end
endmodule  //bin2gray
