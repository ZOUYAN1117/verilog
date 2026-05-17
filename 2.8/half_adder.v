module half_adder (
    input a,
    input b,
    output s,
    output c
);

    assign s = a ^ b; // 计算本位和
    assign c = a & b; // 计算进位

endmodule
