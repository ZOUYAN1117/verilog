module bin2gray (
    input [3:0] bin_code,
    output wire [3:0] gray_code
);

  assign gray_code[3] = bin_code[3];
  assign gray_code[2] = bin_code[3] ^ bin_code[2];
  assign gray_code[1] = bin_code[2] ^ bin_code[1];
  assign gray_code[0] = bin_code[1] ^ bin_code[0];

endmodule  //bin2gray
